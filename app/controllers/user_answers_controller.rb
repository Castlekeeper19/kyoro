class UserAnswersController < ApplicationController
  # before_action :set_user_answer, only: [:update]


  def index
    @user_answers = policy_scope(UserAnswer).where(category: "feedback", status: "unresolved").order(created_at: :desc)
  end

  def update
    @user_answer = UserAnswer.find(params[:id])
    authorize @user_answer
    @user_answer.update(user_answer_params)
    redirect_to user_answers_path
  end

  private

  def set_user_answer
    @user_answer = UserAnswer.find(params[:id])
    authorize @user_answers
  end

  def user_answer_params
    params.require(:user_answer).permit(:category, :status, :content, :action_step)
  end
end
