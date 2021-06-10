class SendSurveyJob < ApplicationJob
  queue_as :default

  # def perform(*args)
  #   puts "I'm starting the fake job"
  #   sleep 3
  #   puts "OK I'm done now"
  # end
  def perform(survey)
    sleep 3
    survey.questions.each do |question|
      answer = Answer.new(
        content: (1..5).to_a,
        category: "Multiple Choice"
      )
      answer.question = question
      answer.save
    end


    SendSlackMessageService.new(
      token: ENV['SLACK_TOKEN'],
      channel: 'C023NB3DQKX',
      message: build_message(survey)
    ).call
  end

  def build_message(survey)
    message = [
      {
        "type": "header",
        "block_id": "#{survey.options}-#{survey.id}",
        "text": {
          "type": "plain_text",
          "text": survey.name,
          "emoji": true
        }
      }
    ]
    if survey.options == "Scale"
      survey.questions.each do |question|
        message <<
        {
          "type": "section",
          "text": {
            "type": "plain_text",
            "text": "#{question.content}",
            "emoji": true
          }
        }
        message <<
        {
          "type": "actions",
          "elements": [
            {
              "type": "button",
              "text": {
                "type": "plain_text",
                "text": "1",
                "emoji": false
              },
              "value": { :question_id => question.id, :question_category => question.category, :answer_value => 1 }.to_json,
              "action_id": "actionId-0"
            },
            {
              "type": "button",
              "text": {
                "type": "plain_text",
                "text": "2",
                "emoji": true
              },
              "value": { :question_id => question.id, :question_category => question.category, :answer_value => 2 }.to_json,
              "action_id": "actionId-3"
            },
            {
              "type": "button",
              "text": {
                "type": "plain_text",
                "text": "3",
                "emoji": true
              },
              "value": { :question_id => question.id, :question_category => question.category, :answer_value => 3 }.to_json,
              "action_id": "actionId-4"
            },
            {
              "type": "button",
              "text": {
                "type": "plain_text",
                "text": "4",
                "emoji": true
              },
              "value": { :question_id => question.id, :question_category => question.category, :answer_value => 4 }.to_json,
              "action_id": "actionId-5"
            },
            {
              "type": "button",
              "text": {
                "type": "plain_text",
                "text": "5",
                "emoji": true
              },
              "value": { :question_id => question.id, :question_category => question.category, :answer_value => 5 }.to_json,
              "action_id": "actionId-6"
            }
          ]
        }
      end
    else
      survey.questions.each do |question|
        message <<
        {
          "type": "section",
          "text": {
            "type": "plain_text",
            "text": "#{question.content}",
            "emoji": true
          }
        }
        message << {
          "type": "actions",
          "elements": [
            {
              "type": "button",
              "style": "primary",
              "text": {
                "type": "plain_text",
                "text": "Yes",
                "emoji": false
              },
              "value": { :question_id => question.id, :question_category => question.category, :answer_value => "Yes" }.to_json,
              "action_id": "actionId-0"
            },
            {
              "type": "button",
              "style": "danger",
              "text": {
                "type": "plain_text",
                "text": "No",
                "emoji": true
              },
              "value": ({ question_id: question.id, :question_category => question.category, :answer_value => "No"}).to_json,
              "action_id": "actionId-3"
            }
          ]
        }
      end
    end
    # message << {
    #   "type": "actions",
    #   "elements": [
    #     {
    #       "type": "button",
    #       "text": {
    #         "type": "plain_text",
    #         "text": "Submit",
    #         "emoji": true
    #       },
    #       "value": "click_me_123",
    #       "action_id": "actionId-0"
    #     }
    #   ]
    # }
    return message
  end
end
