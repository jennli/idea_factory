class CommentsController < ApplicationController
  before_action :find_idea

  def create
    if user_signed_in?
      @comment = Comment.new comment_params
      @comment.user = current_user
      @comment.idea = @idea

      if @comment.save
        redirect_to @idea, notice:"comment saved successfully"
      else
        redirect_to @idea, alert: "Error, try again."
      end

    else
      redirect_to new_session_path, notice:"you need to sign in before leaving a comment"
    end
  end

  def destroy
    if user_signed_in?
      @comment = current_user.comments.find params[:id]
      @comment.destroy
      redirect_to @idea, notice: "comment deleted."
    else
      redirect_to new_session_path, alert:"you must sign in before deleting a comment"
    end
  end

  private

  def comment_params
    params.require(:comment).permit([:body])
  end

  def find_idea
    @idea = Idea.find params[:idea_id]
  end

end
