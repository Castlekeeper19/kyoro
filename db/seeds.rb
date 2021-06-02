# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'


puts "creating seeds"

# 10.times do

#   example = User.create!(
#     name:  Faker::Name.first_name + " " + Faker::Name.last_name,
#     email: Faker::Internet.email,
#     password: Faker::Internet.password,
#     company: "Kyoro Inc.",
#     slack_username: Faker::Internet.username,
#     title: "team member",
#     role: Faker::Job.title,
#     goal: "Improve at: " + Faker::Job.key_skill
#   )

# end

UserAnswer.destroy_all
Answer.destroy_all
Question.destroy_all
Survey.destroy_all


  puts "created #{User.count} Users"
date_count = 0
  user = User.all.sample
  4.times do
    date = Date.today - date_count
    date_count +=7
    survey = Survey.create!(
      name: "General Survey for #{date.strftime("%B %-d %Y")}",
      content: "Please answer this survey",
      user_id: user.id,
      date_sent: date.strftime("%B %-d %Y")
    )
    puts "created #{Survey.count} Survey"
    counter = (User.all.count * rand(0.5..1)).to_i
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

      puts "created #{Question.count} Question"
      1.times do
        answer = Answer.create!(
          question_id: mood.id,
          content: (1..5).to_a,
          category: "Multiple Choice"
        )
        puts "created #{Answer.count} Answers"

        counter.times do
          user = User.all.sample
          UserAnswer.create!(
            answer_id: answer.id,
            user_id: user.id,
            content: rand(1..5),
            category: 'mood',
            response_date: date,
            answer_score: rand(1..5)

          )

        end
      end
      1.times do
        answer = Answer.create!(
          question_id: support.id,
          content: (1..5).to_a,
          category: "Multiple Choice"
        )
        puts "created #{Answer.count} Answers"

        counter.times do
          user = User.all.sample
          UserAnswer.create!(
            answer_id: answer.id,
            user_id: user.id,
            content: rand(1..5),
            category: 'support',
            response_date: date,
            answer_score: rand(1..5)
          )
        end
      end
       1.times do
        answer = Answer.create!(
          question_id: motivation.id,
          content: (1..5).to_a,
          category: "Multiple Choice"
        )
        puts "created #{Answer.count} Answers"

        counter.times do
          user = User.all.sample
          UserAnswer.create!(
            answer_id: answer.id,
            user_id: user.id,
            content: rand(1..5),
            category: 'motivation',
            response_date: date,
            answer_score: rand(1..5)
          )
        end
      end

    end
    puts "created #{UserAnswer.count} User Answers"
       # 1.times do
       #  answer = Answer.create!(
       #    question_id: question.id,
       #    content: ["Red", "Blue", "Yellow"],
       #    category: "Multiple Choice"
       #  )
        # 1.times do
        #   user_answer = UserAnswer.create!(
        #     answer_id: null,
        #     user_id: user.id,
        #     content: "I can't whistle, but none of my team members will teach me!",
        #     category: 'feedback'
        #   )
        #   puts "created #{UserAnswer.count} User Answers"
        # end
      # end
end







# 1.times do
#   Booking.create!(
#   date_time: today,
#   comment: Faker::Lorem.sentence(word_count: 6),
#   status: (0..2).to_a.sample,
#   user_id: example.id,
#   workout_id: example_workout.id
# )
# end
# end
