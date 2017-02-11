class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]
  def home
    @user = current_user
    @classrooms = @user.classrooms
  end

  def landing
    @disable = true
  end
end
