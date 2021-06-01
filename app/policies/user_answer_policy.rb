class UserAnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def index?
    user == record.user
  end

  def update?
    true
  end
end
