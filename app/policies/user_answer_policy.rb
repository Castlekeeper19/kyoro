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
    true
  end

  def update?
    true
  end

  # def create?
  #   true
  # end
end
