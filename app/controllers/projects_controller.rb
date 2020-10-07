class ProjectsController < ApplicationController
    before_action :if_not_logged_in_redirect_to_login
    before_action :find_project, only: [:show, :edit, :update, :destroy]
    
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
        does_project_exist?(params[:id])
    end

    def edit
        does_project_exist?(params[:id])
    end

    def update
        does_project_exist?(params[:id])

        if @project.valid?
            @project.update(project_params)
            
            redirect_to projects_path
        else
            render :edit
        end
    end

    def destroy
        does_project_exist?(params[:id])
        
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

    def does_project_exist?(id)
        exist = Project.find_by_id(id)

        if exist == nil
            flash[:dont_exist] = 'No record in database.'

            redirect_to projects_path
        end
    end

    def find_project
        @project = Project.find_by_id(params[:id])
    end
end
