class PagesController < ApplicationController
  def home
    @user = current_user
    @classrooms = Classroom.all
  end

  def landing
  end
end
