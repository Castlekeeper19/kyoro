class DashboardController < ApplicationController
  def index
    @users = policy_scope(User)
    @survey = policy_scope(Survey).last
    @surveys = policy_scope(Survey).all
    @user_answers = policy_scope(UserAnswer).all
    @team_mood = policy_scope(UserAnswer).overall("mood")
    @team_support = policy_scope(UserAnswer).overall("support")
    @team_motivation = policy_scope(UserAnswer).overall("motivation")
    @team_goals = policy_scope(UserAnswer).overall("personal_goals")
  end
end
