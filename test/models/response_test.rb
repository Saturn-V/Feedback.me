require 'test_helper'

class ResponseTest < ActiveSupport::TestCase
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create(email: 'adam@instructor.com', password: 'password', password_confirmation: 'password', first_name: 'Adam', last_name: 'Braus', instructor: true, student: false)
    @user.save
    sign_in @user

    @classroom = @user.classrooms.build(name: 'Ruby on Rails', class_code: 'xyz', subject: 'CS')

    @form = Form.create(name: 'Sample Form', assesment_type: 'instructor')
    @question_one = @form.questions.create(static: true, free: false, label: 'Sample Question', form: @form)
    @question_two = @form.questions.create(static: false, free: true, label: 'Sample Question', form: @form)

    @response = Response.create(classroom: @classroom, form: @form, user: @user)
    @response.answers.create(response: @response, question: @question_one)
    @response.answers.create(response: @response, question: @question_two)
  end

  # test 'response has one notification' do
  #   assert_equal @response.user, @user
  # end

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

  # Has many forms (?)
  #
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
