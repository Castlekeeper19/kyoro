# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

require 'faker'


puts "creating seeds"

10.times do

  example = User.create!(
    name:  Faker::Name.first_name + " " + Faker::Name.last_name,
    email: Faker::Internet.email,
    password: Faker::Internet.password,
    company: "Kyoro Inc.",
    slack_username: Faker::Internet.username,
    title: "team member",
    role: Faker::Job.title,
    goal: "Improve at: " + Faker::Job.key_skill
  )

end

  puts "created #{User.count} Users"

  user = User.all.sample
  puts user
  2.times do

    survey = Survey.create!(
      name: "Survey",
      content: "Please answer this survey",
      user_id: user.id
    )
    puts "created #{Survey.count} Survey"
    1.times do
      question = Question.create!(
        survey_id: survey.id,
        content: "What is your favorite color?"
      )
      puts "created #{Question.count} Question"
      1.times do
        answer = Answer.create!(
          question_id: question.id,
          content: ["Red", "Blue", "Yellow"],
          category: "Multiple Choice"
        )
        puts "created #{Answer.count} Answers"
        1.times do
          user_answer = UserAnswer.create!(
            answer_id: answer.id,
            user_id: user.id,
            content: "Red",
            category: 'survey_response'
          )
          puts "created #{UserAnswer.count} User Answers"
        end
      end
      1.times do
        answer = Answer.create!(
          question_id: question.id,
          content: ["Red", "Blue", "Yellow"],
          category: "Multiple Choice"
        )
        1.times do
          user_answer = UserAnswer.create!(
            answer_id: answer.id,
            user_id: user.id,
            content: "I can't whistle, but none of my team members will teach me!",
            category: 'feedback'
          )
          puts "created #{UserAnswer.count} User Answers"
        end
      end
    end
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
