class ResponsesController < ApplicationController
  def index
    @responses = current_user.responses.all
  end

  def show
    @response = current_user.responses.find(params[:id])
  end

  def edit
    @response = Response.find(params[:id])
    @form = @response.form
    # @questions.count.times { @response.answers.build }
  end

  def update
    # <section>
    #     <%= f.fields_for :answers do |builder| %>
    #       <% if !Question.find_by(id:builder.object.question_id).nil? %>
    #         <% question = Question.find_by(id:builder.object.question_id) %>
    #
    #         <li><%= question.label %></li>
    #
    #         <ul>
    #           <%= render partial: "partials/answer_fields", locals: { :f => builder, :q => question } %>
    #         </ul>
    #       <% end %>
    #
    #     <% end %>
    # </section>
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
    params.require(:response).permit(:value_static, :value_free, :is_complete, answers_attributes: [:id, :value_static, :value_free, :_destroy])
  end
end
