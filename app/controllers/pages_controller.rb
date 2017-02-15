class PagesController < ApplicationController
  before_action :authenticate_user!, only: [:home]
  def home
    @classrooms = current_user.classrooms
    @feedback_requests = current_user.feedback_requests.last(3)
  end

  def landing
    @disable = true
  end
end
