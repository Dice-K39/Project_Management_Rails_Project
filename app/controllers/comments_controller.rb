class CommentsController < ApplicationController
    before_action :redirect_to_comments_if_not_owner_or_project_manager, only: [:edit, :update, :destroy]
    before_action :does_assignment_exist?
    before_action :does_comment_exist?, only: [:show, :edit, :update, :destroy]
    before_action :find_assignment, only: [:index, :new, :create]
    before_action :find_assignment_comment, only: [:show, :edit, :update, :destroy]

    def index
        @comments = @assignment.comments
    end

    def new
        @comment = @assignment.comments.new
    end

    def create
        @comment = @assignment.comments.new(comment_params)

        @comment.programmer_id = current_programmer.id

        if @comment.valid?
            @comment.save

            redirect_to assignment_comments_path(@comment.assignment_id)
        else
            render :new
        end
    end

    def show
    end

    def edit
    end

    def update
        if @comment.update(comment_params)
            redirect_to assignment_comments_path(@comment.assignment_id)
        else
            render :edit
        end
    end

    def destroy        
        if @comment.destroy
            redirect_to assignment_comments_path(@assignment)
        else
            redirect_to assignment_comments_path(@comment)
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:title, :content, :assignment_id, :programmer_id)
    end

    def does_comment_exist?
        exist = Comment.find_by_id(params[:id])

        if exist == nil
            flash[:dont_exist] = 'No record in database.'

            redirect_to assignment_comments_path(params[:assignment_id])
        end
    end

    def find_assignment_comment
        find_assignment
        
        @comment = @assignment.comments.find_by_id(params[:id])
    end

    def redirect_to_comments_if_not_owner_or_project_manager
        find_assignment_comment

        if !current_programmer.is_project_manager && @comment.programmer_id != current_programmer.id
            flash[:not_admin] = "No access."

            redirect_to assignment_comments_path(@assignment)
        end
    end
end
