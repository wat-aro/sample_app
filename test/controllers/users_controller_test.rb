require 'test_helper'

class UsersControllerTest < ActionController::TestCase

  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end

  test 'should redirect index when not logged in' do
    get :index
    assert_redirected_to new_user_session_url
  end

  test 'should redirect following when not logged in' do
    get :following, id: @user
    assert_redirected_to new_user_session_url
  end

  test 'should redirect followers when not logged in' do
    get :followers, id: @user
    assert_redirected_to new_user_session_url
  end
end
