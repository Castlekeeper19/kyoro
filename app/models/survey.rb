class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions
  has_many :answers, through: :questions
  has_many :user_answers, through: :answers


  validates :content, presence: true
  validates :name, presence: true
end
