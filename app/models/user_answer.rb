class UserAnswer < ApplicationRecord
  belongs_to :answer
  belongs_to :user
  enum status: [:unresolved, :resolved]

  # validates :category, inclusion: { in: ['feedback', 'survey_response'], message: "%{value} is not a valid category" }

    def self.overall(category)
      feeling = 0
      count = 0
      UserAnswer.all.each do |answer|
        if answer.answer.question.category == category
          feeling += answer.answer_score
          count += 1
        end
      end
      ((feeling.to_f/count)*20).to_i
    end
  end


