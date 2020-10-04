class ProjectsController < ApplicationController
    def index
        if_not_logged_in_redirect_to_login

        if_not_project_manager

        @projects = Project.all
    end

    def new
        if_not_logged_in_redirect_to_login

        if_not_project_manager

        @project = Project.new
    end

    def create
        if_not_logged_in_redirect_to_login

        if_not_project_manager

        @project = Project.new(project_params)

        if @project.valid?
            @project.save

            redirect_to projects_path
        else
            render :new
        end
    end

    def show
        if_not_logged_in_redirect_to_login

        find_project
    end

    def edit
        if_not_logged_in_redirect_to_login

        if_not_project_manager

        find_project
    end

    def update
        if_not_logged_in_redirect_to_login

        if_not_project_manager

        @project = Project.find_by_id(params[:id])

        if @project.valid?
            @project.update(project_params)
            
            redirect_to projects_path
        else
            render :edit
        end
    end

    def destroy
        if_not_logged_in_redirect_to_login

        if_not_project_manager
        
        find_project

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

    def find_project
        @project = Project.find_by_id(params[:id])
    end
end
