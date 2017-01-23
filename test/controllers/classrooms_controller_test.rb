require 'test_helper'

class ClassroomsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create(email: 'adam@instructor.com', password: 'password', password_confirmation: 'password', first_name: 'Adam', last_name: 'Braus', instructor: true, student: false)
    @user.save
    sign_in @user
    @classroom = @user.classrooms.create(name: 'Ruby on Rails', class_code: 'xyz', subject: 'CS')
  end

  test "the truth" do
    assert true
  end

  test "should get index" do
    get classrooms_url
    assert_response :success
  end

  test 'should get show' do
    get classroom_url(@classroom)
    assert_response :success
  end

  test "should get new" do
    get new_classroom_url
    assert_response :success
  end

  test "should create classroom" do
    assert_difference('Classroom.count') do
      post classrooms_url, params: { classroom: { name: 'Ruby on Rails', class_code: 'xyz', subject: 'CS' } }
    end
  end
end
