class ProjectsController < ApplicationController
    before_action :find_project, only: [:show, :edit, :update, :destroy]
    before_action :redirect_to_projects_if_not_project_manager, except: [:index, :show]
    before_action :does_project_exist?, only: [:show, :edit, :update, :destroy]
    
    def index
        @projects = Project.all
    end

    def new
        @project = Project.new
    end

    def create
        @project = Project.new(project_params)

        if @project.valid?
            @project.save

            redirect_to projects_path
        else
            render :new
        end
    end

    def show
    end

    def edit
    end

    def update
        if @project.valid?
            @project.update(project_params)
            
            redirect_to projects_path
        else
            render :edit
        end
    end

    def destroy        
        if @project.delete
            redirect_to projects_path
        else
            redirect_to project_path(@project)
        end
    end

    private

    def project_params
        params.require(:project).permit(:name, :description, :due_date, :status)
    end

    def does_project_exist?
        exist = Project.find_by_id(params[:id])

        if exist == nil
            flash[:dont_exist] = 'No record in database.'

            redirect_to projects_path
        end
    end

    def find_project
        @project = Project.find_by_id(params[:id])
    end

    def redirect_to_projects_if_not_project_manager
        if current_programmer.is_project_manager != true
            flash[:not_admin] = "Only Project Manager has access."

            redirect_to projects_path
        end
    end
end
