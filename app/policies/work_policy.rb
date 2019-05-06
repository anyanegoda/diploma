class WorkPolicy < ApplicationPolicy
  attr_reader :current_user, :work

  def initialize(current_user, work)
    @current_user = current_user
    @work = work
  end

  def new?
    @current_user&.admin?
  end

  def create?
    @current_user&.admin?
  end

  def update?
    @current_user&.admin?
  end

  def destroy?
    @current_user&.admin?
  end

end
