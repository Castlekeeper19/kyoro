# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'

puts "Clearing Database"
UserAnswer.destroy_all
Answer.destroy_all
Question.destroy_all
Survey.destroy_all
# User.destroy_all

puts "creating seeds"

positive = [3,3,4,4,4,5,5,5,5,5]
neutral = [1,2,3,3,4,4,4,5,5,5]
negative = [1,1,1,2,2,2,3,3,4]
nature_arrays = [negative, negative, neutral, neutral, neutral, neutral, neutral, positive, positive, positive]

positive_culture = [0, 1, 1]
neutral_culture = [-1,0, 1]
negative_culture = [-1,0,0]
company_culture =[positive_culture, neutral_culture, neutral_culture, negative_culture]

# 20.times do

#   example = User.create!(
#     name:  Faker::Name.first_name + " " + Faker::Name.last_name,
#     email: Faker::Internet.email,
#     password: 123123,
#     company: "Kyoro Inc.",
#     slack_username: Faker::Internet.username,
#     title: "team member",
#     role: Faker::Job.title,
#     nature: nature_arrays.sample,
#     goal: "Improve at: " + Faker::Job.key_skill
#   )
# end

# puts "created #{User.all.count} Users"

date_count = 0
  user = User.all.sample
  12.times do
    date = Date.today - date_count
    date_count +=7
    survey = Survey.create!(
      name: "General Survey",
      content: "Please answer this survey",
      user_id: user.id,
      date_sent: date.strftime("%B %-d %Y"),
      options: "Scale"
    )
    puts "created #{Survey.count} Survey"
    counter = (User.all.count * rand(0.3..1)).to_i
    1.times do
      mood = Question.create!(
        survey_id: survey.id,
        content: "How are you feeling?",
        category: "mood"
      )
      support = Question.create!(
        survey_id: survey.id,
        content: "How well do you feel supported?",
        category: "support"
        )
      motivation = Question.create!(
        survey_id: survey.id,
        content: "How motivated do you feel?",
        category: "motivation"
        )
      personal_goals = Question.create!(
        survey_id: survey.id,
        content: "Are reaching your personal goals?",
        category: "personal_goals"
        )
      1.times do
        answer = Answer.create!(
          question_id: mood.id,
          content: (1..5).to_a,
          category: "Multiple Choice"
        )
        culture = company_culture.sample
        counter.times do
          response_answer = (user.nature.sample.to_i + culture.sample)
          user = User.all.sample
          UserAnswer.create!(
            answer_id: answer.id,
            user_id: user.id,
            content: response_answer,
            category: 'mood',
            response_date: date,
            answer_score: response_answer
          )
        end
      end
      1.times do
        answer = Answer.create!(
          question_id: support.id,
          content: (1..5).to_a,
          category: "Multiple Choice"
        )
        culture = company_culture.sample
        counter.times do
          response_answer = (user.nature.sample.to_i + culture.sample)
          user = User.all.sample
          UserAnswer.create!(
            answer_id: answer.id,
            user_id: user.id,
            content: response_answer,
            category: 'support',
            response_date: date,
            answer_score: response_answer
          )
        end
      end
       1.times do
        answer = Answer.create!(
          question_id: motivation.id,
          content: (1..5).to_a,
          category: "Multiple Choice"
        )
        culture = company_culture.sample
        counter.times do
          response_answer = (user.nature.sample.to_i + culture.sample)
          user = User.all.sample
          UserAnswer.create!(
            answer_id: answer.id,
            user_id: user.id,
            content: response_answer,
            category: 'motivation',
            response_date: date,
            answer_score: response_answer
          )
        end
      end
      1.times do
        answer = Answer.create!(
          question_id: personal_goals.id,
          content: (1..5).to_a,
          category: "Multiple Choice"
        )
        culture = company_culture.sample
        counter.times do
          response_answer = (user.nature.sample.to_i + culture.sample)
          user = User.all.sample
          UserAnswer.create!(
            answer_id: answer.id,
            user_id: user.id,
            content: response_answer,
            category: 'personal_goals',
            response_date: date,
            answer_score: response_answer
          )
        end
      end
    end
    puts "created #{User.count} Users"
    puts "created #{Survey.count} Surveys"
    puts "created #{Question.count} Questions"
    puts "created #{Answer.count} Answers"
    puts "created #{UserAnswer.count} User Answers"
end

  puts "creating anonymous question"
    1.times do
      user_answer = UserAnswer.create!(
        user_id: (User.all.sample).id,
        content: "I have been feeling disconnected from the team recently.",
        category: 'feedback'
      )
      user_answer = UserAnswer.create!(
        user_id: (User.all.sample).id,
        content: "It would be nice if we could have a flexible work schedule.",
        category: 'feedback'
      )
      user_answer = UserAnswer.create!(
        user_id: (User.all.sample).id,
        content: "Working at home has been nice, but sometimes I miss important updates.",
        category: 'feedback'
      )
    end
  puts "created anonymous question"
