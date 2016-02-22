class IdeasController < ApplicationController
  before_action :find_idea, only:[:show, :destroy, :update, :edit]
  def index
    @ideas = Idea.all.order("updated_at")
  end

  def show
    @comments = @idea.comments
  end

  def new
    @idea = Idea.new
  end

  def create
    @idea = Idea.new idea_params
    @idea.user = current_user
    if @idea.save
      redirect_to @idea, notice:"Idea created successfully"

    else
      flash[:alert] = "Idea is not created. Try again"
      render :new
    end


  end

  def update
    if @idea.update idea_params
      redirect_to @idea, notice:"Update success"
    else
      flash[:alert] = "Update failed"
      render :edit
    end
  end

  def destroy
  end

  private
  def idea_params
    params.require(:idea).permit(:title, :body, :avatar)
  end

  def find_idea
    @idea = Idea.find params[:id]
  end
end
