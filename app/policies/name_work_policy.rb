class NameWorkPolicy < ApplicationPolicy
  attr_reader :current_user, :name_work

  def initialize(current_user, name_work)
    @current_user = current_user
    @name_work = name_work
  end

  def index?
    @current_user&.admin?
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
