require 'test_helper'

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create(email: 'adam@instructor.com', password: 'password', password_confirmation: 'password', first_name: 'Adam', last_name: 'Braus', instructor: true, student: false)
    @user.save
    sign_in @user

    @classroom = @user.classrooms.build(name: 'Ruby on Rails', class_code: 'xyz', subject: 'CS')

    @form = Form.create(name: 'Sample Form', assesment_type: 'instructor')
    @question = @form.questions.create(static: true, free: false, label: 'Sample Question', form: @form)

    @response = Response.create(classroom: @classroom, form: @form, user: @user)
    @answer = @response.answers.create(response: @response, question_id: @question)
  end

  test "should get index" do
    get responses_url
    assert_response :success
  end

  test 'should get show' do
    get response_url(@response)
    assert_response :success
  end

  test 'should get edit' do
    get edit_response_url(@response)
    assert_response :success
  end

  test 'should update response' do
    @res = Response.create(classroom: @classroom, form: @form, user: @user)

    patch response_url(@res), params: { response: { is_complete: true } }

    assert_redirected_to classroom_path(@classroom)

    @res.reload

    assert_equal true, @res.is_complete
  end

  test 'should update response answers' do
    @res = Response.create(classroom: @classroom, form: @form, user: @user)
    @ans = @res.answers.create(question: @question)
    patch response_url(@res), params: { response: { is_complete: true, answers_attributes: [{ value_static: 5 }] } }

    # assert_redirected_to classroom_path(@classroom)

    @res.reload
    @res.answers.reload

    assert_equal 5, @res.answers.first.value_static
  end
end
