class Survey < ApplicationRecord
  belongs_to :user
  has_many :questions

  validates :content, presence: true
  validates :name, presence: true
end
