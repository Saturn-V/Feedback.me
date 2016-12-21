class PagesController < ApplicationController
  def home
    @classrooms = Classroom.all
  end
  def landing
  end
end
