require "application_responder"

class ApplicationController < ActionController::Base
#  require 'roo'
  include Pundit
  self.responder = ApplicationResponder
  respond_to :html

  protect_from_forgery with: :exception
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  before_action :configure_permitted_parameters, if: :devise_controller?

  def check_user
    if current_user == nil
      redirect_to new_user_session_path
    end
  end

  protected

  def configure_permitted_parameters
    added_attrs = [:name, :surname, :username, :patronymic, :academic_degree, :post, :rate, :email, :password, :password_confirmation, :remember_me, :avatar, :avatar_cache]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def user_not_authorized
    redirect_to root_path, notice: 'You do not have permission to those resources.'
  end
end
