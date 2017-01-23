require 'test_helper'

class ResponsesControllerTest < ActionDispatch::IntegrationTest
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

  test 'should get edit' do
    get edit_subreddit_url(@subreddit)
  end

  test 'should update subreddit' do
    patch subreddit_url(@subreddit), params: { subreddit: { title: 'updated' } }

    # take user to 'show' subreddit after editing one
    assert_redirected_to subreddit_path(@subreddit)

    # Reload data to fetch updated data and assert that title is updated.
    @subreddit.reload

    assert_equal 'updated', @subreddit.title
  end
end
