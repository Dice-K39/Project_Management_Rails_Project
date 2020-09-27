class CommentsController < ApplicationController
    def index
        @comments = Comment.all
    end

    def new
        @comment = Comment.new
    end

    def create
        comment = Comment.new(comment_params)

        if comment.save
            redirect_to comment_path(comment)
        else
            render :new
        end
    end

    def show
        find_comment
    end

    def edit
        find_comment
    end

    def update
        comment = Comment.find_by_id(params[:id])

        if comment.update(comment_params)
            redirect_to comment_path(comment)
        else
            render :edit
        end
    end

    def destroy
        find_comment

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

    def find_comment
        @comment = Comment.find_by_id(params[:id])
    end
end
