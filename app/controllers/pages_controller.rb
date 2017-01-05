class PagesController < ApplicationController
  def home
    @user = current_user
    @classrooms = @user.classrooms
  end

  def landing
  end
end
