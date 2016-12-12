class FormsController < ApplicationController

  def index
    @classroom = Classroom.find(params[:classroom_id])
  end

  def show
    @classroom = Classroom.find(params[:classroom_id])
    @form = @classroom.forms.find(params[:id])
  end

  def new
    @classroom = Classroom.find(params[:classroom_id])
    @form = @classroom.forms.build
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
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def form_params
    params.require(:form).permit(:name)
  end
end
