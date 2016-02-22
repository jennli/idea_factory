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
    @idea = Idea.new ideas_params
    @idea.user = current_user
    if @idea.save
      redirect_to @idea, notice:"Idea created successfully"

    else
      flash[:alert] = "Idea is not created. Try again"
      render :new
    end


  end

  def update
  end

  def destroy
  end

  private
  def ideas_params
    params.require(:idea).permit(:title, :body)
  end

  def find_idea
    @idea = Idea.find params[:id]
  end
end
