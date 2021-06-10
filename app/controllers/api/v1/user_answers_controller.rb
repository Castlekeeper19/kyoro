require 'uri'
require 'net/http'

class Api::V1::UserAnswersController < Api::V1::BaseController
  skip_after_action :verify_authorized, only: [:webhook]
  before_action :set_user_answer, only: [ :show ]

  def index
    @user_answers = policy_scope(UserAnswer)
  end

  def show

  end

  def webhook
    # params coming from Slack
    if params["command"] == "/feedbackbox"
      @user_answer = UserAnswer.new
      @user_answer.user = User.find_by("slack_username = ?", params["user_id"])
      @user_answer.content = params["text"]
      @user_answer.category = 'feedback'
      @user_answer.save
      render status: 200, json: { response_type: "ephemeral", text: "Thanks for your feedback!" }.to_json
    else
      payload = JSON.parse(params['payload'])
      action = payload['message']['blocks'].first['block_id']
      if action.start_with?("Scale")
        answer_key = JSON.parse(payload["actions"][0]["value"])
        @user_answer = UserAnswer.new
        @user_answer.user = User.find_by("slack_username = ?", payload["user"]["id"])
        @user_answer.answer_score = answer_key["answer_value"]
        @question = Question.find(answer_key["question_id"])
        @user_answer.answer = @question.answers[0]
        @user_answer.category = (answer_key["question_category"].downcase)
        @user_answer.save
        # fetch(payload["response_url"], {
        #         method: "POST",
        #         body: { text: "Thanks! Your answers have been submitted" }.to_json
        # })
        message = [
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": "Thanks! You submitted '#{answer_key["answer_value"]}' to '#{Question.find(answer_key["question_id"]).content}'."
            },
            "block_id": 'event'
          }
        ]

        SendSlackMessageService.new(
          token: ENV['SLACK_TOKEN'],
          channel: payload['user']['id'],
          message: message
        ).call
      else
        answer_key = JSON.parse(payload["actions"][0]["value"])
        @user_answer = UserAnswer.new
        @user_answer.user = User.find_by("slack_username = ?", payload["user"]["id"])
        @user_answer.content = answer_key["answer_value"]
        @question = Question.find(answer_key["question_id"])
        @user_answer.answer = @question.answers[0]
        @user_answer.category = 'other'
        @user_answer.save
        message = [
          {
            "type": "section",
            "text": {
              "type": "mrkdwn",
              "text": "Thanks! You submitted '#{answer_key["answer_value"]}' to '#{Question.find(answer_key["question_id"]).content}'."
            },
            "block_id": 'event'
          }
        ]

        SendSlackMessageService.new(
          token: ENV['SLACK_TOKEN'],
          channel: payload['user']['id'],
          message: message
        ).call
      end
    end
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
