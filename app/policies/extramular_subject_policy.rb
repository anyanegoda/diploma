class ExtramularSubjectPolicy < ApplicationPolicy
  attr_reader :current_user, :extramular_subject

  def initialize(current_user, extramular_subject)
    @current_user = current_user
    @extramular_subject = extramular_subject
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

  def insert_to_bd_extramular?
    @current_user&.admin?
  end

  def destroy_all_extramular_subjects?
    @current_user&.admin?
  end

  def change_ext_user_id?
    @current_user&.admin?
  end

  def remove_extramular_subject?
    @current_user&.admin? || @current_user.id == @extramular_subject.user.id
  end

end
