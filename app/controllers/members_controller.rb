class MembersController < ApplicationController
  before_action :find_idea, only:[:create, :destroy]

  def create
    if user_signed_in?
      member = Member.new(idea: @idea, user: current_user)
      if can? :manage, member
        if member.save
          flash[:notice] = "You joined this idea"
        else
          flash[:alert] = "You didn't join this idea"
        end
        redirect_to @idea
      else
        redirect_to @idea, alert:"you can't be a member of your own idea"
      end
    else
      redirect_to new_session_path
    end
  end

  def destroy
    if user_signed_in?
      @member = Member.find params[:id]
      if can? :manage, @member
        @member.destroy
        redirect_to @idea, notice: "You quit this idea!"
      else
        redirect_to @idea, alert: "you can't quit your own idea"
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
