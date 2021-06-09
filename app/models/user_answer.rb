class UserAnswer < ApplicationRecord
  belongs_to :answer, optional: true
  belongs_to :user, optional: true
  enum status: [:unresolved, :resolved]

  # validates :category, inclusion: { in: ['feedback', 'survey_response'], message: "%{value} is not a valid category" }

#Determines overall team score of category for the past 30 days
  def self.overall(category)
    feeling = 0
    count = 0
    UserAnswer.where("response_date >= ?", (Date.today - 30)).each do |answer|
      if  answer.category != "feedback" && answer.category == category
        feeling += answer.answer_score
        count += 1
      end
    end
    ((feeling.to_f/count)*20).to_i
  end

#Defines number of anonymous user feedback which have not been resolved/have no action step
  def self.notifications
    UserAnswer.where(category: "feedback", status: "unresolved", action_step: ["", nil]).count
  end

#To define color for overall category used in Dashboard pie graph
  def self.color(category)
   score =  UserAnswer.overall(category)
    if score >= 80
      color = "#73BF8F"
    elsif score >= 70
      color = "#FFE270"
    else
      color = "#F1807E"
    end
  end

end
