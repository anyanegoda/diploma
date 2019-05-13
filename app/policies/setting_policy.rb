class SettingPolicy < ApplicationPolicy
  attr_reader :current_user, :setting

  def initialize(current_user, setting)
    @current_user = current_user
    @setting = setting
  end

  def index?
    @current_user&.admin?
  end

  def show?
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

  def save_input_file?
    @current_user&.admin?
  end

  def insert_to_bd?
    @current_user&.admin?
  end

  def destroy_all_subjects?
    @current_user&.admin?
  end

  def insert_to_bd_extramular?
    @current_user&.admin?
  end

  def destroy_all_extramular_subjects?
    @current_user&.admin?
  end

end
