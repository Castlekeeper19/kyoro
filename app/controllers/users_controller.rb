class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = User.all
  end

  def show
  end

  def edit
    if @user.update(user_params)
      redirect_to users_path
    else
      render :edit
    end
  end

  def update
  end

  private

  def user_params
    params.require(:user).permit(:name, :title, :role, :photo)
  end

  def set_user
    @user = User.find(params[:id])
  end
end
