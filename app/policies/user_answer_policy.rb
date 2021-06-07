class UserAnswerPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def webhook?
    !user.nil?
  end

  def update?
    true
  end

end
