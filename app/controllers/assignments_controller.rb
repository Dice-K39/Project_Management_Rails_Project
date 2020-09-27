class AssignmentsController < ApplicationController
    def index
        @assignments = Assignment.all
    end

    def new
        @assignment = Assignment.new
    end

    def create
        @assignment = Assignment.new(assignment_params)

        if @assignment.save
            redirect_to assignment_path(@assignment)
        else
            render :new
        end
    end

    def show
        find_assignment
    end

    def edit
        find_assignment
    end

    def update
        @assignment = Assignment.find_by_id(params[:id])

        if @assignment.update(assignment_params)
            redirect_to assignment_path(@assignment)
        else
            render :edit
        end
    end

    def destroy
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
