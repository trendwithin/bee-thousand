class AlertPolicy < ApplicationPolicy
  def destroy?
    user.admin?
  end

  def create?
    user.admin?
  end
end
