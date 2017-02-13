class FormsController < ApplicationController
  before_action :authenticate_user!

  def index
    @classroom = Classroom.find(params[:classroom_id])
    @forms = Form.all
  end

  def show
    @classroom = Classroom.find(params[:classroom_id])
    @form = Form.find(params[:id])
    @questions = @form.questions
  end

  def new
    @classroom = Classroom.find(params[:classroom_id])
    @form = @classroom.forms.new
    3.times do |n|
      unless n == 2
        question = @form.questions.build
        4.times { question.skills.build }
      else
        question = @form.questions.build
        question.free = true
        question.static = false
      end
    end
  end

  def create
    @classroom = Classroom.find(params[:classroom_id])
    @form = @classroom.forms.new(form_params)

    if @form.save
      flash[:success] = 'Form Created'
      redirect_to classroom_path(@classroom)
    else
      redirect_to :back
      flash[:error] = 'Form failed to be created. One or more fields were blank.'
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def form_params
    params.require(:form).permit(:name, :assesment_type, :_destroy, questions_attributes: [:id, :label, :static, :free, skills_attributes: [:id, :label, :_destroy]])
  end
end
