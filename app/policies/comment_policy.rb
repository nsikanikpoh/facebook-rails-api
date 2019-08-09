class CommentPolicy < ApplicationPolicy
  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def update?
    record.user == user rescue false
  end

  def destroy?
    update?
  end
end
