class ClassroomsController < ApplicationController
  def index
    @user = current_user
    @classrooms = current_user.classrooms.all

    if params[:search]
      @classrooms = Classroom.search(params[:search]).order("created_at DESC")
    else
      @classrooms = Classroom.all.order("created_at DESC")
    end
  end

  def show
    @user = current_user
    # @classroom = @user.classrooms.find(params[:id])
    @classroom = Classroom.find(params[:id])
  end

  def new
    @user = current_user
    @classroom = @user.classrooms.build
  end

  def create
    @user = current_user
    @classroom = @user.classrooms.build(classroom_params)
    @classroom.class_code = SecureRandom.hex(6)[0..6]

    if @user.save
      flash[:success] = 'Classroom Created'
      redirect_to @classroom
    else
      redirect_to :back
      flash[:error] = 'Classroom failed to be created'
    end
  end

  def update

  end

  def join
    @user = current_user
    @classroom = Classroom.find_by(class_code: params[:id])
    @classroom.users << @user
    if @classroom.update_attributes(classroom_params)
      redirect_to @classroom
      flash[:success] = "Succesfully Joined Class!"
    else
      redirect_to :back
      flash[:error] = "Failed to join class."
    end
  end

  def join_classroom
    @classroom
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def classroom_params
    params.require(:classroom).permit(:name)
  end
end
