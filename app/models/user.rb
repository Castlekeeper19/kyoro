class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :validatable
  has_one_attached :photo
  has_many :user_answers
  acts_as_token_authenticatable

  scope :admin_users, -> { where(admin: true) }
  scope :nonadmin_users, -> { where(admin: false || nil) }

  #determines average score for a user for certain category
  def overall(category)
    feeling = 0
    count = 0
    user_answers.each do |user_answer|
      if user_answer.category != "feedback" && user_answer.answer.question.category == category
        feeling += user_answer.content.to_i
        count += 1
      end
    end
    feeling.positive? ? (feeling.to_f/count) : feeling
  end

  #determines average score for a user based on all categories
  def overall_total
    feeling = 0
    count = 0
    user_answers.where(category: ["mood", "motivation", "support", "personal_goals"]).each do |user_answer|
      feeling += user_answer.content.to_i
      count += 1
    end
    feeling.positive? ? ((feeling.to_f / count) * 20).to_i : feeling
  end

  # defines color for a user's category score used on User Show page
  def color(category)
    score = overall(category)
    if score > 3.5
      color = "#73BF8F"
    elsif score > 2.5
      color = "#FFE270"
    else
      color = "#F1807E"
    end
    color
  end

  # defines color for user's overall engagement used on User Index page
  def overall_color
    score = overall_total
    if score > 70
      color = "#73BF8F"
    elsif score > 60
      color = "#FFE270"
    else
      color = "#F1807E"
    end
    color
  end

  scope :overall_total_asc, -> do
    all.sort_by{ |user| user.overall_total }
  end

  scope :overall_total_desc, -> do
    overall_total_asc.reverse
  end

end
