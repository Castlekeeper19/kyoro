class Answer < ApplicationRecord
  belongs_to :question
  has_many :user_answers, dependent: :destroy

  validates :content, presence: true
  validates :category, presence: true
end
