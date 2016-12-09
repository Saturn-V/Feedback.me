class PagesController < ApplicationController
  def home
    @classrooms = Classroom.all
  end
end
