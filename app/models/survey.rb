class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions
  has_many :user_answers, through: :user

  validates :content, presence: true
  validates :name, presence: true
end
