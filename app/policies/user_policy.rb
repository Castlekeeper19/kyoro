class UserPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.where(company: user.company)
    end
  end

  def show?
    return true
  end

  def update?
    return true
  end
end

