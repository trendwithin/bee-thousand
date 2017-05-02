class MicropostPolicy < ApplicationPolicy
  def destroy?
    user.admin?
  end

  def create?
    user.registered? || user.admin?
  end
end
