class MainController < ApplicationController
  before_action :check_user

  def index
    @title = "Добро пожаловать, #{current_user.name}"
    @subtitle = "Выберите нужную категорию."
    @hide_menu = true
  end
end
