class CommentsController < ApplicationController
    before_action :if_not_logged_in_redirect_to_login

    def index
        @assignment = Assignment.find_by_id(params[:assignment_id])
        @comments = @assignment.comments
        # @comments = Assignment.find_by_id(params[:assignment_id]).comments
    end

    def new
        does_assignment_exist?(params[:assignment_id])

        @assignment = Assignment.find_by_id(params[:assignment_id])
        @comment = @assignment.comments.new
    end

    def create
        assignment = Assignment.find_by_id(params[:assignment_id])
        comment = assignment.comments.new(comment_params)

        comment.programmer_id = current_programmer.id

        if comment.valid?
            comment.save

            redirect_to assignment_comments_path(comment.assignment_id)
        else
            render :new
        end
    end

    def show
        assignment = Assignment.find_by_id(params[:assignment_id])
        @comment = assignment.comments.find_by_id(params[:id])
    end

    def edit
        redirect_if_not_current_programmer_or_project_manager(session[:programmer_id])

        @assignment = Assignment.find_by_id(params[:assignment_id])
        @comment = Comment.find_by_id(params[:id])
    end

    def update
        redirect_if_not_current_programmer_or_project_manager(session[:programmer_id])

        @comment = Comment.find_by_id(params[:id])

        if @comment.update(comment_params)
            redirect_to assignment_comments_path(@comment.assignment_id)
        else
            render :edit
        end
    end

    def destroy
        redirect_if_not_current_programmer_or_project_manager(session[:programmer_id])
        
        assignment = Assignment.find_by_id(params[:assignment_id])
        comment = Comment.find_by_id(params[:id])

        if comment.delete
            redirect_to assignment_comments_path(comment.assignment_id)
        else
            redirect_to assignment_comments_path(comment)
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:title, :content, :assignment_id, :programmer_id)
    end
end
