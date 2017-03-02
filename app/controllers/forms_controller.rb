class FormsController < ApplicationController
  before_action :authenticate_user!

  def index
    @classroom = Classroom.find(params[:classroom_id])
    @forms = Form.all.order("created_at DESC")
  end

  def show
    @classroom = Classroom.find(params[:classroom_id])
    @form = Form.find(params[:id])
    @questions = []
    @categories = []
    @form.categories.each do |category|
      @questions += (category.questions)
      @categories.push(category)
    end
    # binding.pry
  end

  def new
    @classroom = Classroom.find(params[:classroom_id])
    @form = @classroom.forms.new
    @form.assesment_type = 'Instructor'
    category = @form.categories.build
    category.name = 'Free Response'
    question = category.questions.build
    question.free = true
    question.static = false
  end

  def create
    @classroom = Classroom.find(params[:classroom_id])
    @form = @classroom.forms.new(form_params)
    @form.created_by_id = current_user.id
    if @form.save!
      flash[:success] = 'Form Created'
      redirect_to classroom_form_path(@classroom, @form)
    else
      redirect_to :back
      flash[:error] = 'Form failed to be created. One or more fields were blank.'
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def form_params
    params.require(:form).permit(:name, :assesment_type, :created_by_id, :_destroy, categories_attributes: [:id, :name, :_destroy, questions_attributes: [:id, :label, :static, :free, :_destroy, skills_attributes: [:id, :label, :_destroy]]])
  end
end
