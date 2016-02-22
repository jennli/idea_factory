class UsersController < ApplicationController
  before_action :find_user, only: [:show, :edit, :update, :edit_password, :update_password]

  def create
    @user = User.new user_params
    if @user.save
      login(@user)
      redirect_to root_path, notice: "Account created!"
    else
      flash[:alert] = "Error creating user. see error below"
      render :new
    end
  end

  def new
    @user = User.new
  end

  def show

  end

  def edit

  end

  def update
    if @user.update user_params
      redirect_to @user, notice: "update successfully"
    else
      render :edit
    end
  end

  def edit_password
  end

  def update_password
    if @user.authenticate(params[:user][:old_password]) && (@user.update user_params)
      redirect_to @user, notice: "password update successfully"
    else
      flash[:alert]="Invalid. Please try again."
      render :edit_password
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end

  def find_user
    @user = User.find params[:id]
  end

end
