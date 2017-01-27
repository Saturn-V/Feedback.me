require 'test_helper'

class ResponsesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = User.create(email: 'adam@instructor.com', password: 'password', password_confirmation: 'password', first_name: 'Adam', last_name: 'Braus', instructor: true, student: false)
    @user.save
    sign_in @user
    @classroom = @user.classrooms.build(name: 'Ruby on Rails', class_code: 'xyz', subject: 'CS')
    @form = Form.create(name: 'Sample Form', assesment_type: 'instructor')
    @response = Response.create(classroom: @classroom, form: @form, user: @user)
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
    @res = Response.create(classroom: @classroom, form: @form, user: @user, is_complete: false)

    patch response_url(@response), params: { response: { is_complete: true } }

    # @res.is_complete = true

    # @res.save

    # take user to 'show' subreddit after editing one
    # assert_redirected_to classroom_path(@classroom)

    # Reload data to fetch updated data and assert that title is updated.
    # @response.reload

    assert_equal true, @response.is_complete
  end
end
