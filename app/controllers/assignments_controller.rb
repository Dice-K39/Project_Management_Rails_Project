class AssignmentsController < ApplicationController
    before_action :redirect_to_assignments_if_not_project_manager, except: [:index, :show, :update]
    before_action :check_for_assignment, only: [:show, :edit, :update, :destroy]

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
    end

    def edit
    end

    def update
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
        if @assignment.destroy
            redirect_to assignments_path
        else
            redirect_to assignment_path(@assignment)
        end
    end

    private

    def assignment_params
        params.require(:assignment).permit(:task, :assigned_at, :is_completed, :programmer_id, :project_id)
    end

    def check_for_assignment
        does_assignment_exist?

        find_assignment
    end
end
