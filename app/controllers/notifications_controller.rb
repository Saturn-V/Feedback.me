class NotificationsController < ApplicationController

  def index
    @incomplete_notifications = Notification.where(recipient: current_user).incomplete
    @complete_notifications = Notification.where(recipient: current_user).completed
  end

  def create
    @classroom = Classroom.find(params[:classroom_id])
    @form = Form.find(params[:id])

    @feedback_request = current_user.feedback_requests.create(classroom: @classroom)

    (@classroom.users.uniq - [current_user]).each do |user|
      @response = Response.create(classroom: @classroom, form: @form, user: user, feedback_request: @feedback_request)
      @feedback_request.responses << @response
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
