class AssignmentsController < ApplicationController
    before_action :if_not_logged_in_redirect_to_login
    before_action :redirect_to_assignments_if_not_project_manager, only: [:new, :create, :edit, :update, :destroy]

    def index
        if params[:query]
            @assignments = Assignment.assignment_search(params[:query])
        else
            @assignments = Assignment.all
        end
    end

    def new
        @assignment = Assignment.new
    end

    def create
        @assignment = Assignment.new(assignment_params)

        if @assignment.save
            redirect_to programmers_path
        else
            render :new
        end
    end

    def show
        does_assignment_exist?(params[:id])

        @assignment = find_assignment
    end

    def edit
        does_assignment_exist?(params[:id])

        @assignment = find_assignment
    end

    def update
        does_assignment_exist?(params[:id])

        @assignment = find_assignment

        if !current_programmer.is_project_manager && @assignment.is_completed == false
            @assignment.update_attribute(:is_completed, true)

            redirect_to assignment_path(@assignment)
        elsif @assignment.update(assignment_params)
            redirect_to assignment_path(@assignment)
        else
            render :edit
        end
    end

    def destroy
        does_assignment_exist?(params[:id])
        
        @assignment = find_assignment

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
        Assignment.find_by_id(params[:id])
    end
end
