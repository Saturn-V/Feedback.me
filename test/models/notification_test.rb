require 'test_helper'

class NotificationTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  def setup
    @instructor = User.create(email: 'adam@instructor.com', password: 'password', password_confirmation: 'password', first_name: 'Adam', last_name: 'Braus', instructor: true, student: false)
    @instructor.save
    sign_in @instructor

    @student = User.create(email: 'alex@student.com', password: 'password', password_confirmation: 'password', first_name: 'Alex', last_name: 'Pena', instructor: false, student: true)
    @student.save

    @classroom = @instructor.classrooms.build(name: 'Ruby on Rails', class_code: 'xyz', subject: 'CS')

    @form = Form.create(name: 'Sample Form', assesment_type: 'instructor')
    @question_one = @form.questions.create(static: true, free: false, label: 'Sample Question', form: @form)
    @question_two = @form.questions.create(static: false, free: true, label: 'Sample Question', form: @form)

    @response = Response.create(classroom: @classroom, form: @form, user: @student)
    @answer = @response.answers.create(response: @response, question: @question_one)
    @response.answers.create(response: @response, question: @question_two)

    @notification = Notification.create(recipient: @student, sender: @instructor, response: @response)
  end

  test 'notification belongs to recipient' do
    assert_equal @student, @notification.recipient
  end

  test 'notification belongs to sender' do
    assert_equal @instructor, @notification.sender
  end

  test 'notification belongs to response' do
    assert_equal @response, @notification.response
  end
end
