class ProjectsController < ApplicationController
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

            redirect_to project_path(@project)
        else
            render :new
        end
    end

    def show
        find_project
    end

    def edit
        find_project
    end

    def update
        @project = Project.find_by_id(params[:id])

        if @project.valid?
            @project.update(project_params)
            
            redirect_to projects_path
        else
            render :edit
        end
    end

    def destroy
        find_project

        if @project.delete
            redirect_to new_project_path
        else
            redirect_to programmer_path(@project)
        end
    end

    private

    def project_params
        params.require(:project).permit(:name, :description, :due_date, :status)
    end

    def find_project
        @project = Project.find_by_id(params[:id])
    end
end
