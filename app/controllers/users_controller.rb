class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    @users = policy_scope(User).order(name: :asc)
    @users = @users.where("name ILIKE ?", "%#{params[:query]}%") if params[:query].present?

    if params[:sort] == "overall_total_asc"
      @users = @users.overall_total_asc
    elsif params[:sort] == "overall_total_desc"
      @users = @users.overall_total_desc
    end
  end

  def show; end

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to user_path(@user)
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :company, :title, :goal, :role, :slack_username, :photo, :email, :note)
  end

  def set_user
    @user = User.find(params[:id])
    authorize @user
  end
end
