class UserPolicy < ApplicationPolicy
  attr_reader :current_user, :user

  def initialize(current_user, user)
    @current_user = current_user
    @user = user
  end

  def update?
    @current_user.id == @user.id
  end

  def destroy?
    @current_user&.admin? || @current_user.id == @user.id
  end
end
