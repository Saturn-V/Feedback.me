class ClassroomsController < ApplicationController

  def index
    @user = current_user
    @classrooms = @user.classrooms.sort_by(&:created_at)
  end

  def show
    # @classroom = @user.classrooms.find(params[:id])
    @classroom = Classroom.find(params[:id])
    @user = @classroom.users.first
    @feedbacks = []
    responses = @classroom.responses.where(is_complete: true)
    responses.each do |response|
      response.answers.each do |answer|
        if !answer.value_free.nil?
          @feedbacks += [answer]
        end
      end
    end

    @instructor_p = chart_instructor_performance(@classroom)
    gon.chart_months = chart_months
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
    params.require(:classroom).permit(:name, :subject)
  end

  # Data for charts
  def chart_months
    current_month = Date.today.month
    month_names = 6.downto(1).map { |n|
      DateTime::MONTHNAMES.drop(1)[(current_month - n) % 12]
    }
    return month_names
  end

  def chart_instructor_performance(classroom)
    response_answers = Hash.new
    instructor_performance = []

    responses = classroom.responses.for_instructors.order('created_at DESC')

    responses.each do |response|
      response_month = response.created_at.to_datetime.month
      # response_answers.push(response.created_at.to_datetime.month)
      answers = response.answers.for_static
      answers.each do |answer|

        if !response_answers[response_month].nil?
          if !response_answers[response_month][responses.index(response)].nil?
            response_answers[response_month][responses.index(response)][answers.index(answer)] = answer
          end
        else
          response_answers[response_month] = Hash.new
          response_answers[response_month][responses.index(response)] = Hash.new
          response_answers[response_month][responses.index(response)][answers.index(answer)] = answer
          # response_answers.push(answer)
        end
      end
    end

    for month in response_answers
      for response in response_answers[month]
        for answer in response_answers[month][response]



    return response_answers
  end
end
