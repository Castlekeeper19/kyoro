class Question < ApplicationRecord
  belongs_to :survey
  has_many :answers
  has_many :user_answers, through: :answers

  validates :content, presence: true
end
