class LikesController < ApplicationController
  before_action :find_idea, only:[:create, :destroy]

  def create
    if user_signed_in?
      like = Like.new(idea: @idea, user: current_user)
      if can? :manage, like
        if like.save
          IdeaMailer.notify_idea_owner(like).deliver_later
          flash[:notice] = "liked"
        else
          flash[:alert] = "unliked"
        end
        redirect_to @idea
      else
        redirect_to @idea, alert:"you can't like your own idea"
      end
    else
      redirect_to new_session_path
    end
  end

  def destroy
    if user_signed_in?
      @like = Like.find params[:id]
      if can? :manage, @like
        @like.destroy
        redirect_to @idea, notice: "Un-liked!"
      else
        redirect_to @idea, alert: "you can't unlike your own idea"
      end
    else
      redirect_to new_session_path
    end
  end

  private
  def find_idea
    @idea = Idea.find params[:idea_id]
  end

end
