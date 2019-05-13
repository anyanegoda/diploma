class SubjectPolicy < ApplicationPolicy
  attr_reader :current_user, :subject

  def initialize(current_user, subject)
    @current_user = current_user
    @subject = subject
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

  def change_user_id?
    @current_user&.admin?
  end

  def remove_subject?
    @current_user&.admin? || @current_user.id == @subject.user.id
  end

end
