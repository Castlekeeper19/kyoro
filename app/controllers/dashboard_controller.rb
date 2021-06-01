class DashboardController < ApplicationController
  def index
    @users = User.all
    @user_answers = UserAnswer.all
    @surveys = Survey.all
  end
end
