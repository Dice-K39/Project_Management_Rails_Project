class AssignmentsController < ApplicationController
    def index
        if_not_logged_in_redirect_to_login

        redirect_if_not_current_programmer_or_project_manager(session[:programmer_id])
        
        @assignments = Assignment.all
    end

    def new
        if_not_logged_in_redirect_to_login

        if_not_project_manager

        @assignment = Assignment.new
    end

    def create
        if_not_logged_in_redirect_to_login

        if_not_project_manager

        @assignment = Assignment.new(assignment_params)

        if @assignment.save
            redirect_to programmers_path
        else
            render :new
        end
    end

    def show
        if_not_logged_in_redirect_to_login

        redirect_if_not_current_programmer_or_project_manager(session[:programmer_id])

        does_assignment_exist?(params[:id])

        find_assignment
    end

    def edit
        if_not_logged_in_redirect_to_login

        if current_programmer.is_project_manager? != true
            flash[:only_project_manager] = 'Only Project Manager has access.'

            redirect_to assignments_path(current_programmer)
        end

        find_assignment
    end

    def update
        if_not_logged_in_redirect_to_login

        if_not_project_manager

        @assignment = Assignment.find_by_id(params[:id])

        if @assignment.update(assignment_params)
            redirect_to assignment_path(@assignment)
        else
            render :edit
        end
    end

    def destroy
        if_not_logged_in_redirect_to_login

        if current_programmer.is_project_manager? != true
            flash[:only_project_manager] = 'Only Project Manager has access.'

            redirect_to assignments_path(current_programmer)
        end
        
        find_assignment

        if @assignment.delete
            redirect_to '/'
        else
            redirect_to assignment_path(@assignment)
        end
    end

    private

    def assignment_params
        params.require(:assignment).permit(:task, :assigned_at, :is_completed, :programmer_id, :project_id)
    end

    def find_assignment
        @assignment = current_programmer.assignments.find_by_id(params[:id])
    end

    def does_assignment_exist?(id)
        exist = current_programmer.assignments.find_by_id(id)

        if exist == nil
            flash[:dont_exist] = 'No record in database.'

            redirect_to assignments_path
        end
    end
end
