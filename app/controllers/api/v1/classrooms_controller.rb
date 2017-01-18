class Api::V1::ClassroomsController < Api::V1::BaseController
  before_action :authenticate_request!

  def index
    binding.pry
    @user = User.find(JsonWebToken.decode(request.headers['Authorization'].split(' ').last))
    respond_with @user.classrooms.all
    # render json: {'logged_in' => true}
  end

  def show
    @user = current_user
    # @classroom = @user.classrooms.find(params[:id])
    @classroom = Classroom.find(params[:id])
  end

  def new
    @user = current_user
    @classroom_new = @user.classrooms.build
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
    @classroom = Classroom.find(params[:id])
    @classroom.users << @user
    if @classroom.update_attributes(classroom_params)
      redirect_to @classroom
      flash[:success] = "Succesfully Joined Class!"
    else
      redirect_to :back
      flash[:error] = "Failed to join class."
    end
  end

  def join_classroom_search
  end

  def join_classroom
    @user = current_user
    @classroom = nil
    if params[:search]
      @classroom = Classroom.find_by(class_code: params[:search])
    else
      # @recipes = Recipe.all.order("created_at DESC")
      flash[:error] = "Failed to find class."
    end

    if params[:join]
      @classroom.users << @user
      if @user.save
        redirect_to classrooms_path
      end
    end
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def classroom_params
    params.require(:classroom).permit(:name)
  end
end
