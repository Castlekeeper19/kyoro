class UserAnswersController < ApplicationController

  def index
    # @user_answers = policy_scope(UserAnswer).all
    @user_answers = UserAnswer.all
  end

  private

  # def set_user_answer
  #   @user_answer = UserAnswer.find(params[:id])
  #   authorize @user_answers
  # end

  def user_answer_params
    params.require(:user_answer).permit(:category, :status, :content, :action_step)
  end
end
