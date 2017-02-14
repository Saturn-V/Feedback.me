class ClassroomsController < ApplicationController
  before_action :authenticate_user!
  # GET /classrooms
  def index
    @user = current_user
    @classrooms = @user.classrooms.sort_by(&:created_at)
  end

  # GET /classrooms/:id
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
    @feedbacks.reverse!

    # For Charts
    # @test = chart_inst_ans_hash(chart_inst_sorted(@classroom))
    answers_hash = chart_inst_ans_hash(chart_inst_sorted(@classroom))
    month_numbers = chart_month_numbers(chart_month_names)

    gon.chart_month_names = chart_month_names
    gon.chart_inst_compiled = chart_ans_array(answers_hash, month_numbers)

    # gon.chart_responses_received = @classroom.
  end

  # GET /classrooms/new
  def new
    @user = current_user
    @classroom = @user.classrooms.build
  end

  def create
    @classroom = current_user.classrooms.build(classroom_params)
    @classroom.class_code = SecureRandom.hex(6)[0..6]

    if current_user.save!
      flash[:success] = 'Classroom Created'
      redirect_to @classroom
    else
      redirect_to :back
      flash[:error] = 'Classroom failed to be created'
    end
  end

  def join_classroom_search
  end

  # Results
  def join_classroom
    @classroom = nil
    @is_enrolled = true
    # Params hash contains class_code that was [:SEARCH]ed
    if params[:search]
      @classroom = Classroom.find_by(class_code: params[:search])
      unless @classroom.users.include?(current_user)
        @is_enrolled = false
      end
    else
      flash[:error] = "Failed to find class."
    end

    # if params[:join]
    #   unless @classroom.users.include?(current_user)
    #     @classroom.users << current_user
    #   end
    #
    #   if current_user.save
    #     redirect_to classrooms_path
    #   end
    # end
  end

  def join
    current_user
    @classroom = Classroom.find(params[:id])
    unless @classroom.users.include?(current_user)
      @classroom.users << current_user

      if @classroom.update_attributes(classroom_params)
        redirect_to @classroom
        flash[:success] = "Succesfully Joined Class!"
      else
        redirect_to :back
        flash[:error] = "Failed to join class."
      end
    else
      redirect_to :back
      flash[:success] = "You are already enrolled in this classroom!"
    end

  end

  def select
    @classrooms = current_user.classrooms.sort_by(&:created_at)
  end

  private

  # Never trust parameters from the scary internet, only allow the white list through.
  def classroom_params
    params.require(:classroom).permit(:name, :subject)
  end

  # Data for charts below
  def chart_month_names
    current_month = Date.today.month
    month_names = 6.downto(1).map { |n|
      DateTime::MONTHNAMES.drop(1)[(current_month - n) % 12]
    }
    return month_names
  end

  def chart_month_numbers(month_names)
    month_numbers = []
    month_names.each do |month|
      month_numbers.push(DateTime::MONTHNAMES.index(month))
    end
    return month_numbers
  end

  def chart_inst_sorted(classroom)
    response_answers = Hash.new
    instructor_performance = Hash.new(0)

    responses = classroom.responses.for_instructors.order('created_at ASC')

    responses.each do |response|

      response_month = response.created_at.to_datetime.month
      response_form_name = response.form.name
      answers = response.answers.for_static

      answers.each do |answer|

        if response_answers[response_month].nil?
          response_answers[response_month] = Hash.new
          response_answers[response_month][response_form_name] = Hash.new
          response_answers[response_month][response_form_name][responses.index(response)] = Hash.new
          response_answers[response_month][response_form_name][responses.index(response)][answers.index(answer)] = answer
        elsif response_answers[response_month][response_form_name].nil?
          response_answers[response_month][response_form_name] = Hash.new
          response_answers[response_month][response_form_name][responses.index(response)] = Hash.new
          response_answers[response_month][response_form_name][responses.index(response)][answers.index(answer)] = answer
        elsif response_answers[response_month][response_form_name][responses.index(response)].nil?
          response_answers[response_month][response_form_name][responses.index(response)] = Hash.new
          response_answers[response_month][response_form_name][responses.index(response)][answers.index(answer)] = answer
        else
          response_answers[response_month][response_form_name][responses.index(response)][answers.index(answer)] = answer
        end

        if instructor_performance[response_month] != 0
          # There is a value here!
          # Let's append the current iterated value to our list!
          instructor_performance[response_month] += answer.value_static
          if response == response_answers[response_month][response_form_name].values.last
            # We are in the last resonse!
            if answer = response_answers[response_month][response_form_name][responses.index(response)].values.last
              # This is the final answer in this response!
              # Let's divide the current value by the number of answers in this response!
              instructor_performance[response_month] = instructor_performance[response_month] / response.count
            end
          end
        else
          instructor_performance[response_month] = answer.value_static
        end
      end
    end

    # return instructor_performance
    return response_answers
  end

  def chart_inst_ans_hash(months_answers_hash)
    inst_performance = Hash.new(0)

    months_answers_hash.each do |month, forms|
      month_form_total = 0

      forms.each_with_index do |(form, responses), form_index|
        form_response_total = 0

        responses.each_with_index do |(response, answers), response_index|

          answers.each do |pos, answer|
            if inst_performance[month] != 0
              form_response_total += answer.value_static
            else
              form_response_total = answer.value_static
            end
          end

          if response_index == (responses.size - 1)
            form_response_total = form_response_total / responses.size
            month_form_total += form_response_total
          end

        end

        if form_index == forms.size - 1
          month_form_total = month_form_total / forms.size
          # month_form_total = normalize(month_form_total)
          inst_performance[month] = month_form_total
        end

      end
    end

    inst_performance = normalize(inst_performance)
    return inst_performance
  end

  def normalize(performance_hash)
    if performance_hash.empty?
      6.times do |n|
        performance_hash[n] = 0
      end
    else
      xmin = performance_hash.min_by{|k,v| v}[1]
      xmax = performance_hash.max_by{|k,v| v}[1]
      # This is our normalized range, data is always displayed in this range
      ymin = 0
      ymax = 5

      xrange = xmax - xmin
      yrange = ymax - ymin

      performance_hash.each do |key, value|
        performance_hash[key] = ymin + (value - xmin) * (yrange.to_f / xrange)
      end
    end

    # binding.pry
    return performance_hash
  end

  def chart_ans_array(answers_hash, month_nums)
    answers_array = [0, 0, 0, 0, 0, 0]
    month_nums.each_with_index do |month, index|
      if answers_hash.key?(month)
        answers_array[index] = answers_hash[month]
      end
    end

    return answers_array
  end
end
