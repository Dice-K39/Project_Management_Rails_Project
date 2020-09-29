class AssignmentsController < ApplicationController
    def index
        if_not_logged_in_redirect_to_login
        
        @assignments = Assignment.all
    end

    def new
        if_not_logged_in_redirect_to_login

        @assignment = Assignment.new
    end

    def create
        if_not_logged_in_redirect_to_login

        @assignment = Assignment.new(assignment_params)

        if @assignment.save
            redirect_to assignment_path(@assignment)
        else
            render :new
        end
    end

    def show
        if_not_logged_in_redirect_to_login

        find_assignment
    end

    def edit
        if_not_logged_in_redirect_to_login

        find_assignment
    end

    def update
        if_not_logged_in_redirect_to_login

        @assignment = Assignment.find_by_id(params[:id])

        if @assignment.update(assignment_params)
            redirect_to assignment_path(@assignment)
        else
            render :edit
        end
    end

    def destroy
        if_not_logged_in_redirect_to_login
        
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
        @assignment = Assignment.find_by_id(params[:id])
    end
end
