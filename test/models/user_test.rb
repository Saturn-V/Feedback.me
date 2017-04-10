require 'test_helper'

class UserTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  # test "the truth" do
  #   assert true
  # end

  def setup
    @instructor = User.create(email: 'instructorTest@user.com', password: 'password', password_confirmation: 'password', instructor: true, student: false)
    sign_in @instructor
    @student = User.create(email: 'student@user.com', password: 'password', password_confirmation: 'password', instructor: false, student: true)
  end

  test 'User(Instructor) should be able to CREATE a classroom' do
    classroom = @instructor.classrooms.create(name: 'Rails')
    assert @instructor.classrooms.size, 1
  end

  test 'user(Instructor) can have many classrooms' do
    classroom_1 = @instructor.classrooms.create(name: 'Rails')
    classroom_2 = @instructor.classrooms.create(name: 'Full-Stack JavaScript')
    classroom_3 = @instructor.classrooms.create(name: 'Advanced iOS')
    assert @instructor.classrooms.size, 3
  end

  test 'User(Instructor) should be able to CREATE a feedback request' do
    classroom = @instructor.classrooms.create(name: 'Rails')
    form = @instructor.forms.create(name: 'Core')
    feedback_request = @instructor.feedback_requests.create(classroom: classroom, form: form)
    assert @instructor.feedback_requests.size, 1
  end

  test 'User(Student) should be able to JOIN a classroom' do
    classroom = @instructor.classrooms.create(name: 'Rails')
    @student.join(classroom.class_code)
    assert @student.classrooms.size, 1
  end

  test 'User(Student) can belong to many classrooms' do
    # Creating classrooms as an instructor
    classroom_1 = @instructor.classrooms.create(name: 'Rails')
    classroom_2 = @instructor.classrooms.create(name: 'Full-Stack JavaScript')
    classroom_3 = @instructor.classrooms.create(name: 'Advanced iOS')

    # Joining classrooms as a student
    @student.join(classroom_1.class_code)
    @student.join(classroom_2.class_code)
    @student.join(classroom_3.class_code)

    assert @student.classrooms.size, 3
    assert @student.classrooms.first, classroom_1
    assert @student.classrooms.second, classroom_2
    assert @student.classrooms.third, classroom_3
    # Add tests for checking if student object is in studets of classroom
  end

  test 'User(student) should receive a notification after instructor sends a feedback_request' do
    classroom = @instructor.classrooms.create(name: 'Rails') # Instructor creates classroom
    form = @instructor.forms.create(name: 'Core') # Instructor creates form
    feedback_request = @instructor.feedback_requests.create(classroom: classroom, form: form) # Instructor sends feedback_request

    assert @student.notifications.size, 1
  end
end
