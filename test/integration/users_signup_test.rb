require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  def setup
    ActionMailer::Base.deliveries.clear
  end

  test 'invalid signup information' do
    get new_user_registration_path
    assert_no_difference 'User.count' do
      post users_path, user: { name: '',
                               email: 'user@invalid',
                               password: 'foo',
                               password_confirmation: 'bar' }
    end
    assert_template 'users/registrations/new'
  end

  test 'valid signup information with account activation' do
    get new_user_registration_path
    assert_difference 'User.count', 1 do
      post '/users', user: { name: 'Example User',
                             email: 'user@example.com',
                             password: 'password',
                             password_confirmation: 'password' }
    end
    # assert_equal 1, ActionMailer::Base.deliveries.size
    user = assigns(:user)
    assert_not user.confirmed_at?
    # 有効化していない状態でログインしてみる
    log_in_as(user)
    assert_not user.confirmed_at
    # 有効化トークンが不正な場合
    get user_confirmation_path(confirmation_token: 'invalid token', email: user.email)
    assert_not user.confirmed_at
    # トークンは正しいがメールアドレスが無効な場合
    get user_confirmation_path(confirmation_token: user.confirmation_token, email: 'wrong')
    assert_not user.confirmed_at
    # 有効化トークンが正しい場合
    get user_confirmation_path(confirmation_token: user.confirmation_token, email: user.email)
    assert user.reload.confirmed_at
  end
end
