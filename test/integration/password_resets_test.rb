require 'test_helper'

class PasswordResetsTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
    @user = users(:michael)
  end

  test 'password resets' do
    # get new_user_password_path
    # assert_template 'users/passwords/new'
    # # メールアドレスが無効
    # post user_password_path, user: { email: '' }
    # assert_template 'users/passwords/new'
    # # メールアドレスが有効
    # post '/users/password', user: { email: @user.email }
    # assert_not_equal @user.reset_password_token, @user.reload.reset_password_token
    # assert_equal 1, ActionMailer::Base.deliveries.size
    # assert_not 'p.notice'.empty?
    # assert_redirected_to new_user_session_path
    # # パスワード再設定用フォーム
    # user = assigns(:user)
    # token = user.reset_password_token
    # # メールアドレスが無効
    # get edit_user_password_path(token, email: '')
    # assert_redirected_to new_user_session_path
    # # 無効なユーザー
    # user.toggle!(:confirmed_at)
    # get edit_user_password_path(token, email: user.email)
    # assert_redirected_to new_user_session_url
    # user.toggle!(:confirmed_at)
    # # トークンが無効
    # get edit_user_password_path(reset_password_token: 'wrong token')
    # assert_template 'users/passwords/edit'
    # patch '/users/password', user: {
    #         reset_password_token: 'wrong token',
    #         password: 'foobaz',
    #         password_confirmation: 'foobaz' }

    # assert_template 'users/passwords/edit'
    # トークンが有効
    # get edit_user_password_path(reset_password_token: token)
    # assert_template 'users/passwords/edit'
    # # 無効なパスワードと確認
    # patch '/users/password', user: {
    #         reset_password_token: token,
    #         password: 'foobaz',
    #         password_confirmation: 'barquux' }
    # assert_select 'div#error_explanation'
    # # パスワードが空
    # get edit_user_password_path(reset_password_token: token)
    # patch '/users/password', user: {
    #         reset_password_token: token,
    #         password: '',
    #         password_confirmation: '' }
    # assert_select 'div#error_explanation'
    # 有効なパスワードと確認
    # get edit_user_password_path(reset_password_token: token)
    # put '/users/password', user: {
    #         password: 'foobaz',
    #         password_confirmation: 'foobaz',
    #         reset_password_token:  }
    # assert_not 'p.alert'.empty?
    # assert_template 'microposts/_micropost'
  end
end
