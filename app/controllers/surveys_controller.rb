class SurveysController < ApplicationController
  before_action :set_survey, only: [:show]

  def index
    @surveys = policy_scope(Survey)
    @surveys = Survey.all

    # @progress =
  end

  def show
  end

  def new
    @survey = Survey.new
    # @survey.questions.build.answers.build
    @questions = @survey.questions.build
    @answers = @questions.answers.build
    # @survey.answers.build

    authorize @survey
  end

  def create
    @survey = Survey.new(survey_params)
    @survey.user = current_user
    authorize @survey

    if @survey.save
      redirect_to survey_path(@survey)

      SendSlackMessageService.new(
        token: ENV['SLACK_TOKEN'],
        channel: 'C023NB3DQKX',
        message: build_message
      ).call
    else
      render 'new.html.erb'
    end
  end

  private

  def set_survey
    @survey = Survey.find(params[:id])
    authorize @survey
  end

  def survey_params
    params.require(:survey).permit(:name, :content, questions_attributes: [:content, answers_attributes: [:content, :category]])
  end

  def build_message
    message = [
      {
        "type": "section",
        "text": {
          "type": "plain_text",
          "text": @survey.name,
          "emoji": true
        }
      }
    ]
    @survey.questions.each do |question|
      message << {
        "type": "input",
        "element": {
          "type": "static_select",
          "placeholder": {
            "type": "plain_text",
            "text": "1-5",
            "emoji": true
          },
          "options": [
            {
              "text": {
                "type": "plain_text",
                "text": "1",
                "emoji": true
              },
              "value": "value-1"
            },
            {
              "text": {
                "type": "plain_text",
                "text": "2",
                "emoji": true
              },
              "value": "value-2"
            },
            {
              "text": {
                "type": "plain_text",
                "text": "3",
                "emoji": true
              },
              "value": "value-3"
            },
            {
              "text": {
                "type": "plain_text",
                "text": "4",
                "emoji": true
              },
              "value": "value-4"
            },
            {
              "text": {
                "type": "plain_text",
                "text": "5",
                "emoji": true
              },
              "value": "value-5"
            }
          ],
          "action_id": "static_select-action"
        },
        "label": {
          "type": "plain_text",
          "text": question.content,
          "emoji": true
        }
      }
    end
    return message
  end
end

class SendSlackMessageService
  attr_reader :channel, :message, :token

  def initialize(attributes)
    @channel = attributes[:channel]
    @message = attributes[:message]
    @token = attributes[:token]
  end

  def call
    response = HTTParty.post(
      'https://slack.com/api/chat.postMessage',
      body: {
        channel: channel,
        blocks: message
      }.to_json,
      headers: {
        'Content-Type' => 'application/json',
        'Authorization' => ('Bearer ' + token)
      }
    )
    p response

  end
end
