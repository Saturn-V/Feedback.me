class NotificationsController < ApplicationController

  def index
    @notifications = Notification.where(recipient: current_user)
  end

  def create
    @classroom = Classroom.find(params[:classroom_id])
    @form = Form.find(params[:id])

    (@classroom.users.uniq - [current_user]).each do |user|
      @response = Response.create!(user: user, form: @form, classroom: @classroom)
      @form.questions.each do |question|
        @response.answers.create
      end
      Notification.create(recipient: user, sender: current_user, response: @response)
    end

    redirect_to root_path
  end
end
