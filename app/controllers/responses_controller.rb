class ResponsesController < ApplicationController
  before_action :authenticate_user!

  def show_request
    @request = current_user.feedback_requests.find(params[:id])
    @submitted_responses = @request.responses.submited
    @incomplete_responses = @request.responses.incomplete
    @students = Classroom.students(@request.classroom)
    @classroom = @request.classroom

    @feedbacks = []
    responses = @request.responses.submited
    responses.each do |response|
      response.answers.each do |answer|
        if !answer.value_free.nil?
          @feedbacks += [answer]
        end
      end
    end
    @feedbacks.reverse!
  end

  def show
    @response = current_user.responses.find(params[:id])
    form = @response.form
    @competencies = []
    @categories = []
    form.categories.each do |category|
      @competencies += (category.competencies)
      @categories.push(category)
    end
  end

  def edit
    @response = Response.find(params[:id])
  end

  def update
    @response = Response.find(params[:id])
    @classroom = @response.classroom

    @response.updated_at = Time.zone.now
    @response.is_complete = true

    if @response.update(response_params)
      redirect_to classroom_path(@classroom)
      flash[:notice] = "Response completed"
    else
      redirect_back(fallback_location: edit_response_path(@response))
      flash[:error] = "Response failed to update"
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def response_params
    params.require(:response).permit(:is_complete,
                                      answers_attributes: [:id, :response_id, :value_static, :value_free])
  end
end
