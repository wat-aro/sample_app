require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'login with invalid information' do
    get new_user_session_path
    assert_template 'sessions/new'
    post new_user_session_path, session: { email: '', password: '' }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end

  test 'login with valid information followed by logout' do
    get new_user_session_path
    log_in_as @user
    assert_redirected_to root_path
    follow_redirect!
    assert_template 'microposts/_micropost'
    assert_select 'a[href=?]', new_user_session_path, count: 0
    assert_select 'a[href=?]', destroy_user_session_path
    assert_select 'a[href=?]', user_path(@user)
    delete destroy_user_session_path
    assert_not @user_current_sign_in_at
    assert_redirected_to root_url
    # ２番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    delete destroy_user_session_path
    follow_redirect!
    assert_select 'a[href=?]', new_user_session_path
    assert_select 'a[href=?]', destroy_user_session_path, count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end
end
