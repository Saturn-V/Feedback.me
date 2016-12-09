class ClassroomsController < ApplicationController
  def show
    @classroom = Classroom.find(params[:id])
  end

  def new
    @classroom = Classroom.new
  end

  def create
    @classroom = Classroom.new(classroom_params)

    if @classroom.save
      flash[:success] = 'Classroom Created'
      redirect_to classroom_path(@classroom)
    else
      redirect_to :back
      flash[:error] = 'Classroom failed to be created'
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def classroom_params
    params.require(:classroom).permit(:name)
  end
end
