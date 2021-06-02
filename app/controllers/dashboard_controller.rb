class DashboardController < ApplicationController
  def index
    @users = policy_scope(User)
    @survey = policy_scope(Survey).last
    @surveys = policy_scope(Survey).all
    @user_answers = policy_scope(UserAnswer).all
  end
end
