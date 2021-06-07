json.array! @user_answers do |user_answer|
  json.extract! user_answer, :id, :content
end
