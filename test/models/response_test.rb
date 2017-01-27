require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create(email: 'adam@instructor.com', password: 'password', password_confirmation: 'password', first_name: 'Adam', last_name: 'Braus', instructor: true, student: false)
    @user.save
    # sign_in @user
    @classroom = @user.classrooms.build(name: 'Ruby on Rails', class_code: 'xyz', subject: 'CS')
    @form = Form.create(name: 'Sample Form', assesment_type: 'instructor')
    @response = Response.create(classroom: @classroom, form: @form, user: @user)
    # 3.times do
    #   @form.questions.build(label: "Sample")
    # end
  end

  # test 'response has one notification' do
  #   assert_equal @response.user, @user
  # end

  test 'response belongs to user' do
    assert_equal @response.user, @user
  end

  test 'response belongs to classroom' do
    assert_equal @response.classroom, @classroom
  end

  test 'response belongs to form' do
    assert_equal @response.form, @form
  end

  # test 'classroom has class_code' do
  #   assert_equal @classroom.class_code, 'xyz'
  # end
  #
  # test 'classroom has subject' do
  #   assert_equal @classroom.subject, 'CS'
  # end

  # Has many forms (?)
  #
  # test 'classroom can contain responses' do
  #   assert_equal @classroom.responses.count, 1
  # end
  #
  # test 'classroom can contain users' do
  #   assert_equal @classroom.users.count, 1
  # end

  # test "title should be present" do
  #   @subreddit.title = nil
  #   assert_not @subreddit.valid?
  # end
  #
  # test "title is too long" do
  #   @subreddit.title = "i"*40
  #   assert_not @subreddit.valid?
  # end
end
