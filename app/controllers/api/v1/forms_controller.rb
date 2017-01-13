class FormsController < ApplicationController

  def index
    @classroom = Classroom.find(params[:classroom_id])
    @forms = Form.all
  end

  def show
    @classroom = Classroom.find(params[:classroom_id])
    @form = @classroom.forms.find(params[:id])
    @questions = @form.questions
  end

  def new
    session[:form_params] ||= {}
    @classroom = Classroom.find(params[:classroom_id])
    @form = @classroom.forms.build
    3.times do
      question = @form.sections.build.build_question
    end

    # @form.current_step = session[:form_step]
  end

  def create
    @classroom = Classroom.find(params[:classroom_id])
    @form = @classroom.forms.build(form_params)
    if @form.save
      flash[:success] = 'Form Created'
      redirect_to classroom_path(@classroom)
    else
      redirect_to :back
      flash[:error] = 'Form failed to be created'
    end

    # session[:form_params].deep_merge!(params[:form]) if params[:form]
    # @form = @classroom.forms.build(form_params)
    # @form.current_step = session[:form_step]
    # if @form.valid?
    #   if params[:back_button]
    #     @form.previous_step
    #   elsif @form.last_step?
    #     @form.save if @form.all_valid?
    #   else
    #     @form.next_step
    #   end
    #   session[:form_step] = @form.current_step
    # end
    # if @form.new_record?
    #   render "new"
    #   # redirect_to :back
    #   # flash[:error] = 'Form failed to be created'
    # else
    #   session[:form_step] = session[:form_params] = nil
    #   flash[:notice] = "Form Created!"
    #   redirect_to classroom_path(@classroom)
    # end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def form_params
    params.require(:form).permit(:name, :five_tier)
  end
end
