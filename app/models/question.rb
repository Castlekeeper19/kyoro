class Question < ApplicationRecord
  belongs_to :survey
  has_many :answers, dependent: :destroy
  accepts_nested_attributes_for :answers

  has_many :user_answers, through: :answers

  validates :content, presence: true
end
