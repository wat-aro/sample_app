require 'rails_helper'

RSpec.describe 'Users login' do
  before do
    @user = create(:user)
    @user.microposts.create(content: 'Lorem ipsum')
  end

  it 'login with invalid information' do
    get new_user_session_path
    assert_template 'sessions/new'
    post new_user_session_path, session: { email: '', password: '' }
    assert_template 'sessions/new'
    expect(flash).not_to be_empty
    get root_path
    expect(flash).to be_empty
  end

  it 'login with valid information followed by logout' do
    get new_user_session_path
    login_as @user
    get root_path
    assert_template 'microposts/_micropost'
    assert_select 'a[href=?]', new_user_session_path, count: 0
    assert_select 'a[href=?]', destroy_user_session_path
    assert_select 'a[href=?]', user_path(@user)
    expect{
      delete destroy_user_session_path
    }.not_to change(@user, :current_sign_in_at)
    expect(response).to redirect_to root_url

    # 2番目のウィンドウでログアウトをクリックするユーザーをシミュレートする
    delete destroy_user_session_path
    follow_redirect!
    assert_select 'a[href=?]', new_user_session_path
    assert_select 'a[href=?]', destroy_user_session_path, count: 0
    assert_select 'a[href=?]', user_path(@user), count: 0
  end
end
