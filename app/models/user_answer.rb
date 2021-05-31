class UserAnswer < ApplicationRecord
  belongs_to :answer
  belongs_to :user
  enum status: [:pending, :confirmed, :declined]

end
