class ResponsesController < ApplicationController
  def edit
    @response = Response.find(params[:id])
    @form = @response.form
    @questions = @form.questions
    # @questions.count.times { @response.answers.build }
  end

  def update
    @response = Response.find(params[:id])

    if @response.update_attributes(response_params)
      redirect_to root_path
      flash[:success] = "Response completed"
    else
      redirect_to :back
      flash[:error] = "Response failed to update"
    end
  end

  def index
    @responses = current_user.responses.all
  end

  def show
    @response = current_user.responses.find(params[:id])
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def response_params
    params.require(:response).permit(:value_static, :value_free, :complete, answers_attributes: [:id, :value_static, :value_free])
  end
end
