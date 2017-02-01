class NotificationsController < ApplicationController

  def index
    @notifications = Notification.where(recipient: current_user).unread
  end

  def create
    @classroom = Classroom.find(params[:classroom_id])
    @form = Form.find(params[:id])

    (@classroom.users.uniq - [current_user]).each do |user|
      @response = Response.create(classroom: @classroom, form: @form, user: user)
      @form.questions.each do |question|
        @response.answers.create(question: question)
      end

      Notification.create(recipient: user, sender: current_user, response: @response)
    end

    redirect_to root_path
  end

  def mark_as_read
    @notification = Notification.find(:id)
    @notifications.update_all(read_at: Time.zone.now)
  end
end
