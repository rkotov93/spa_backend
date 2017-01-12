class PostPolicy < ApplicationPolicy
  def update?
    user == record.user
  end

  def destroy?
    user == record.user
  end

  class Scope < Scope
    def resolve
      scope
    end
  end
end
