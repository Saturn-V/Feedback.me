class ResponsesController < ApplicationController
  def index
    @responses = current_user.responses.all
  end

  def show
    @response = current_user.responses.find(params[:id])
  end

  def edit
    @response = Response.find(params[:id])
  end

  def update
    @response = Response.find(params[:id])
    @classroom = @response.classroom

    binding.pry

    if @response.update_attributes!(response_params)
      redirect_to classroom_path(@classroom)
      flash[:success] = "Response completed"
    else
      redirect_back(fallback_location: edit_response_path(@response))
      flash[:error] = "Response failed to update"
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def response_params
    params.require(:response).permit(:is_complete, answers_attributes: [:id, :value_static, :value_free])
  end
end
