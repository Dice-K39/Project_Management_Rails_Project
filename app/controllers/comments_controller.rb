class CommentsController < ApplicationController
    def index
        @comments = Assignment.find_by_id(params[:assignment_id]).comments
    end

    def new
        @assignment = Assignment.find_by_id(params[:assignment_id])
        @comment = Comment.new(assignment_id: params[:assignment_id])
    end

    def create
        assignment = current_programmer.assignments.find_by_id(params[:assignment_id])
        comment = Comment.new(comment_params)
        # comment = current_programmer.assignments(params[:assignment_id]).comments.new(comment_params.merge(params[:assignment_id]))
        # comment = current_programmer.comments.new(comment_params.merge(params[:assignment_id])) #Comment.new(comment_params)
        comment[:assignment_id] = assignment.id

        if comment.valid?
            comment.save

            redirect_to assignment_comments_path(comment.assignment_id) #@comment 
        else
            render :new
        end
    end

    def show
        assignment = Assignment.find_by_id(params[:assignment_id])
        @comment = assignment.comments.find_by_id(params[:id])
    end

    def edit
        @assignment = Assignment.find_by_id(params[:assignment_id])
        @comment = Comment.find_by_id(params[:id])
    end

    def update
        @comment = Comment.find_by_id(params[:id])

        if @comment.update(comment_params)
            redirect_to assignment_comments_path(@comment.assignment_id)
        else
            render :edit
        end
    end

    def destroy
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
