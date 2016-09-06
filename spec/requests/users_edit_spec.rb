require 'rails_helper'

RSpec.describe 'Users edit', type: :request do
  before do
    @user = create(:user)
  end

  it 'unsuccessfull edit' do
    login_as @user
    get edit_user_registration_path
    expect(response.status).to eq 200
    assert_template 'users/registrations/edit'
    patch user_registration_path, user: { name: '',
                                          email: 'foo@invalid',
                                          current_password: 'testtest',
                                          password: 'foo',
                                          password_confirmation: 'bar' }
    assert_template 'users/registrations/edit'
  end

  it 'successfull edit with friendly forwarding' do
    get edit_user_registration_path
    login_as @user
    follow_redirect!
    expect(response).to redirect_to edit_user_registration_path
    name = 'Foo Bar'
    email = 'foo@bar.com'
    patch user_registration_path, user: { name: name,
                                          email: email,
                                          current_password: '' }
    expect(flash).not_to be_empty
    assert edit_user_registration_path
    @user.reload
    expect(@user.name).not_to eq name
    expect(@user.email).not_to eq email
    name = 'Foo Bar'
    email = 'foo@bar.com'
    patch user_registration_path, user: { name: name,
                                          email: email,
                                          current_password: 'testtest',
                                          password: 'foobar',
                                          password_confirmation: 'foobar' }
    @user.reload
    expect(@user.name).to eq name
  end
end
