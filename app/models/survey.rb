class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions, dependent: :destroy
  accepts_nested_attributes_for :questions


  has_many :answers, through: :questions, dependent: :destroy
  accepts_nested_attributes_for :answers

  has_many :user_answers, through: :answers


  validates :content, presence: true
  validates :name, presence: true


# Finds the number of responses to specific survey
  def response_number
    responses =  user_answers.distinct.count("user_id")
    return responses
  end

# Finds rate of response to a specific survey from total users
  def response_rate
    responses = response_number
    rate = responses.to_f / User.all.count * 100
    rate.to_i
  end

# Sets the color for survey bar charts based on response rate
  def response_color
    rate = response_rate
    if rate > 80
      color = "#73BF8F"
    elsif rate > 70
      color = "#FFE270"
    elsif rate > 50
      color = "#FFAE4C"
    else
      color = "#F1807E"
    end
  end

# Finds the average response score for a certain category
  def average_response(category)
    responses = user_answers.all
    answers = []
    count = 0
      responses.each do |response|
        if response.answer.question.category == category
          answers << response.content
          # count += 1
        end
      end
      # (total.to_f / count).round(2)
      answers
  end

  def low_responses(category)
    responses = user_answers.where(answer_score: 1, category: category)
    responses.count
  end
end
