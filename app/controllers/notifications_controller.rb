class NotificationsController < ApplicationController

  def index
    @incomplete_notifications = Notification.where(recipient: current_user).incomplete.order("created_at DESC")
    @complete_notifications = Notification.where(recipient: current_user).completed
  end

  def create
    @classroom = Classroom.find(params[:classroom_id])
    @form = Form.find(params[:id])

    @feedback_request = current_user.feedback_requests.create(classroom: @classroom, form: @form)

    (@classroom.users.uniq - [current_user]).each do |user|
      @response = Response.create(classroom: @classroom, form: @form, user: user, feedback_request: @feedback_request)
      @feedback_request.responses << @response
      @form.categories.each do |category|
        category.competencies.each do |competency|
          @response.answers.create(competency: competency)
        end
      end
      # @form.competencies.each do |competency|
      #   @response.answers.create(competency: competency)
      # end

      Notification.create(recipient: user, sender: current_user, response: @response)
    end

    redirect_to root_path
    flash[:success] = "Form sent succesfully."
  end

  def mark_as_read
    @notification = Notification.find(:id)
    @notifications.update_all(read_at: Time.zone.now)
  end
end
