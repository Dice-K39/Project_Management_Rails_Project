class CommentsController < ApplicationController
    before_action :if_not_logged_in_redirect_to_login

    def index
        does_assignment_exist?(params[:assignment_id])

        find_assignment
        @comments = @assignment.comments
    end

    def new
        find_assignment

        @comment = @assignment.comments.new
    end

    def create
        find_assignment

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
        does_assignment_exist?(params[:assignment_id])
        does_comment_exist?(params[:id])

        find_assignment
        find_comment
    end

    def edit
        does_assignment_exist?(params[:assignment_id])
        does_comment_exist?(params[:id])

        find_assignment
        find_comment
    end

    def update
        does_assignment_exist?(params[:assignment_id])
        does_comment_exist?(params[:id])

        find_comment

        if @comment.update(comment_params)
            redirect_to assignment_comments_path(@comment.assignment_id)
        else
            render :edit
        end
    end

    def destroy        
        find_comment
        
        if @comment.delete
            redirect_to assignment_comments_path(@comment.assignment_id)
        else
            redirect_to assignment_comments_path(@comment)
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:title, :content, :assignment_id, :programmer_id)
    end

    def find_assignment
        @assignment = Assignment.find_by_id(params[:assignment_id])
    end

    def does_comment_exist?(id)
        exist = Comment.find_by_id(id)

        if exist == nil
            flash[:dont_exist] = 'No record in database.'

            redirect_to assignment_comments_path(params[:assignment_id])
        end
    end

    def find_comment
        @comment = Comment.find_by_id(params[:id])
    end
end
