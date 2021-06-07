class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update]

  def index
    # @users = User.where(company: current_user.company)
    # @users = policy_scope(User).order(created_at: :desc)
    if params[:query].present?
      @users = policy_scope(User).where("name ILIKE ?", "%#{params[:query]}%").order("created_at DESC")
    else
      @users = policy_scope(User).all
    end
  end

  def show

  end

  def edit
  end

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
