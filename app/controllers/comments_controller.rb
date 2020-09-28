class CommentsController < ApplicationController
    def index
        @comments = Assignment.find_by_id(params[:assignment_id]).comments
    end

    def new
        @assignment = Assignment.find_by_id(params[:assignment_id])
        @comment = Comment.new(assignment_id: params[:assignment_id])
    end

    def create
        @comment = Comment.new(comment_params) #current_user.comments.new(comment_params.merge(params[:assignment_id]))

        if @comment.valid?
            @comment.save
byebug
            redirect_to assignment_comments_path(@comment.assignment_id) #@comment 
        else
            render :new
        end
    end

    def show
        @comment = Comment.find_by_id(params[:id])
    end

    def edit
        @comment = Comment.find_by_id(params[:id])
    end

    def update
        @comment = Comment.find_by_id(params[:id])

        if @comment.update(comment_params)
            redirect_to assignment_comments_path
        else
            render :edit
        end
    end

    def destroy
        @comment = Comment.find_by_id(params[:id])

        if @comment.delete
            redirect_to '/'
        else
            redirect_to comment_path(@comment)
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:title, :content, :assignment_id)
    end
end
