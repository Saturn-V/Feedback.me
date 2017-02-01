require 'test_helper'

class AnswerTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers
  
  def setup
    @user = User.create(email: 'adam@instructor.com', password: 'password', password_confirmation: 'password', first_name: 'Adam', last_name: 'Braus', instructor: true, student: false)
    @user.save
    sign_in @user
    @classroom = @user.classrooms.create(name: 'Ruby on Rails', class_code: 'xyz', subject: 'CS')
    @form = Form.create(name: 'Sample Form', assesment_type: 'instructor')
    @response = Response.create(classroom: @classroom, form: @form, user: @user)
  end

  test 'response belongs to user' do
    assert_equal @user, @response.user
  end

  test 'response belongs to classroom' do
    assert_equal @classroom, @response.classroom
  end

  test 'response belongs to form' do
    assert_equal @form, @response.form
  end

  test 'response has default is_complete' do
    assert_equal false, @response.is_complete
  end

  test 'response has many answers' do
    assert_equal 2, @response.answers.count
  end
end
