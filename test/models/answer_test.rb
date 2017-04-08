require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  # def setup
  #   @user = User.create(email: 'adam@instructor.com', password: 'password', password_confirmation: 'password', first_name: 'Adam', last_name: 'Braus', instructor: true, student: false)
  #   @user.save
  #   sign_in @user
  #
  #   @classroom = @user.classrooms.build(name: 'Ruby on Rails', class_code: 'xyz', subject: 'CS')
  #
  #   @form = Form.create(name: 'Sample Form', assesment_type: 'instructor')
  #   @question_one = @form.questions.create(static: true, free: false, label: 'Sample Question', form: @form)
  #   @question_two = @form.questions.create(static: false, free: true, label: 'Sample Question', form: @form)
  #
  #   @response = Response.create(classroom: @classroom, form: @form, user: @user)
  #   @answer = @response.answers.create(response: @response, question: @question_one)
  #   @response.answers.create(response: @response, question: @question_two)
  # end
  #
  # test 'answer belongs to response' do
  #   assert_equal @response, @answer.response
  # end
  #
  # test 'answer belongs to question' do
  #   assert_equal @question_one, @answer.question
  # end
end
