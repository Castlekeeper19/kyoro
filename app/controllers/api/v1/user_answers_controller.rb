class Api::V1::UserAnswersController < Api::V1::BaseController

  # skip_before_action :verify_authenticity_token
  acts_as_token_authentication_handler_for User, except: [ :index, :show ]
  before_action :set_user_answer, only: [ :show ]

  def index
    @user_answers = policy_scope(UserAnswer)
  end

  def show

  end

  def webhook


    params coming from Slack
    payload = JSON.parse(params['payload'])
    action = payload['message']['blocks'].first['block_id']

    case action
      when action == "survey"
        @user_answer = UserAnswer.new
        @user_answer.user = current_user

      end
    # when 'another'

    # end

  #   @user_answer = UserAnswer.new(user_answer_params)
  #   @user_answer.user = current_user
  #   authorize @user_answer
  #   if @user_answer.save
  #     render :show
  #   else
  #     render_error
  #   end
  end


  private

  def set_user_answer
    @user_answer = UserAnswer.find(params[:id])
    authorize @user_answer
  end

  def render_error
    render json: { errors: @user_answer.errors.full_messages },
      status: :unprocessable_entity
  end

  def user_answer_params
    params.require(:user_answer).permit(:category, :status, :content, :action_step)
  end

end
