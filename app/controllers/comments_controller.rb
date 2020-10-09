class CommentsController < ApplicationController
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

        find_assignment_comment
    end

    def edit
        redirect_to_comments_if_not_owner

        does_assignment_exist?(params[:assignment_id])
        does_comment_exist?(params[:id])

        find_assignment_comment
    end

    def update
        redirect_to_comments_if_not_owner
        does_assignment_exist?(params[:assignment_id])
        does_comment_exist?(params[:id])

        find_assignment_comment

        if @comment.update(comment_params)
            redirect_to assignment_comments_path(@comment.assignment_id)
        else
            render :edit
        end
    end

    def destroy
        redirect_to_comments_if_not_owner

        find_assignment_comment
        
        if @comment.delete
            redirect_to assignment_comments_path(@assignment)
        else
            redirect_to assignment_comments_path(@comment)
        end
    end

    private

    def comment_params
        params.require(:comment).permit(:title, :content, :assignment_id, :programmer_id)
    end

    def does_comment_exist?(id)
        exist = Comment.find_by_id(id)

        if exist == nil
            flash[:dont_exist] = 'No record in database.'

            redirect_to assignment_comments_path(params[:assignment_id])
        end
    end

    def find_assignment
        @assignment = Assignment.find_by_id(params[:assignment_id])
    end

    def find_assignment_comment

        @assignment = Assignment.find_by_id(params[:assignment_id])
        @comment = @assignment.comments.find_by_id(params[:id])

    end

    def redirect_to_comments_if_not_owner
        find_assignment_comment

        if !current_programmer.is_project_manager && @comment.programmer_id != current_programmer.id
            flash[:not_admin] = "No access."

            redirect_to assignment_comments_path(@assignment)
        end
    end
end
