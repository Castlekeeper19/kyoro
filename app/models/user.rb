class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :user_answers

  def overall(category)
    feeling = 0
    count = 0
    self.user_answers.each do |user_answer|
      if user_answer.answer.question.category == category
        feeling += user_answer.content.to_i
        count += 1
    end
  end
   feeling > 0 ? (feeling.to_f/count) : feeling
 end

 def overall_total
  feeling = 0
  count = 0
  self.user_answers.each do |user_answer|
    feeling += user_answer.content.to_i
    count += 1
  end
    feeling > 0 ? ((feeling.to_f/count)*20).to_i : feeling
 end
end
