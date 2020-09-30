class CommentsController < ApplicationController
    def index
        if_not_logged_in_redirect_to_login

        @comments = Assignment.find_by_id(params[:assignment_id]).comments
    end

    def new
        if_not_logged_in_redirect_to_login

        redirect_if_not_current_programmer(session[:programmer_id])

        @assignment = Assignment.find_by_id(params[:assignment_id])
        @comment = Comment.new(assignment_id: params[:assignment_id])
    end

    def create
        if_not_logged_in_redirect_to_login

        redirect_if_not_current_programmer(session[:programmer_id])

        assignment = current_programmer.assignments.find_by_id(params[:assignment_id])
        comment = Comment.new(comment_params)
        
        comment[:assignment_id] = assignment.id

        if comment.valid?
            comment.save

            redirect_to assignment_comments_path(comment.assignment_id) #@comment 
        else
            render :new
        end
    end

    def show
        if_not_logged_in_redirect_to_login

        assignment = Assignment.find_by_id(params[:assignment_id])
        @comment = assignment.comments.find_by_id(params[:id])
    end

    def edit
        if_not_logged_in_redirect_to_login

        redirect_if_not_current_programmer(session[:programmer_id])

        @assignment = Assignment.find_by_id(params[:assignment_id])
        @comment = Comment.find_by_id(params[:id])
    end

    def update
        if_not_logged_in_redirect_to_login

        redirect_if_not_current_programmer(session[:programmer_id])

        @comment = Comment.find_by_id(params[:id])

        if @comment.update(comment_params)
            redirect_to assignment_comments_path(@comment.assignment_id)
        else
            render :edit
        end
    end

    def destroy
        if_not_logged_in_redirect_to_login

        redirect_if_not_current_programmer(session[:programmer_id])
        
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
        params.require(:comment).permit(:title, :content, :assignment_id)
    end
end
