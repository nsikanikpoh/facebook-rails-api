class ApplicationPolicy
  attr_reader :user, :record

  class Scope < Struct.new(:user, :scope)
    def resolve
      scope
    end
  end

  def initialize(user, record)
    @user = user
    @record = record
  end

  def scope
    Pundit.policy_scope!(user, record.is_a?(Class) ? record : record.class)
  end
end
