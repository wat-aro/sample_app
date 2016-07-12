require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
  end

  test 'unsuccessfull edit' do
    log_in_as(@user)
    get edit_user_registration_path
    assert_response :success
    assert_template 'users/registrations/edit'
    patch_via_redirect users_path, user: { name: '',
                                           email: 'foo@invalid',
                                           current_password: 'password',
                                           password: 'foo',
                                           password_confirmation: 'bar' }
    assert_template 'users/registrations/edit'
  end

  test 'successful edit with friendly forwarding' do
    get edit_user_registration_path
    log_in_as @user
    assert_redirected_to edit_user_registration_path
    name = 'Foo Bar'
    email = 'foo@bar.com'
    patch_via_redirect users_path, user: { name: name,
                                           email: email,
                                           current_password: '' }
    assert_not flash.empty?
    assert edit_user_registration_path
    @user.reload
    assert_not_equal name, @user.name
    assert_not_equal email, @user.email
    name = 'Foo Bar'
    email = 'foo@bar.com'
    patch_via_redirect '/users', user: { name: name,
                                         email: email,
                                         current_password: 'password',
                                         password: 'foobar',
                                         password_confirmation: 'foobar' }
    @user.reload
    assert_equal name, @user.name
    assert @user.unconfirmed_email
  end
end
