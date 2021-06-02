class UserAnswer < ApplicationRecord
  belongs_to :answer
  belongs_to :user
  has_a :question, through: :answer
  enum status: [:unresolved, :resolved]

  validates :category, inclusion: { in: ['feedback', 'survey_response'], message: "%{value} is not a valid category" }
end
