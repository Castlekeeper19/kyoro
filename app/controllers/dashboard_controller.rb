class DashboardController < ApplicationController
  def index
    @users = policy_scope(User)
    @survey = policy_scope(Survey).order(:created_at).last
    @user_answers = policy_scope(UserAnswer).includes(:answer)
    @team_mood = @user_answers.overall("mood")
    @team_support = @user_answers.overall("support")
    @team_motivation = @user_answers.overall("motivation")
    @team_goals = @user_answers.overall("personal_goals")
    @action_steps = policy_scope(UserAnswer).where.not(action_step: [nil, ''], status: "resolved")
  end
end
