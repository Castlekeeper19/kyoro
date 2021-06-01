class DashboardController < ApplicationController
  def index
    @users = policy_scope(User)
    @survey = policy_scope(Survey).last

  end
end
