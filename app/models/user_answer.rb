class UserAnswer < ApplicationRecord
  belongs_to :answer
  belongs_to :user
  enum status: [:unresolved, :resolved]

  validates :category, inclusion: { in: ['feedback', 'survey_response'], message: "%{value} is not a valid category" }
end
