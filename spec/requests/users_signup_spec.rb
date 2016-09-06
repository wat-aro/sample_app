require 'rails_helper'

RSpec.describe 'Users signup', type: :request do
  before do
    ActionMailer::Base.deliveries.clear
  end

  it 'invalid signup information' do
    get new_user_registration_path
    expect{
      post users_path, user: { name: '',
                               email: 'user@invalid',
                               password: 'foo',
                               password_confirmation: 'bar' }
    }.not_to change(User, :count)
    assert_template 'users/registrations/new'
  end

  it 'valid signup information with account activation' do
    get new_user_registration_path
    expect{
      post user_registration_path, user: { name: 'Example User',
                                           email: 'user@example.com',
                                           password: 'password',
                                           password_confirmation: 'password' }
    }.to change(User, :count).by(1)
  end
end
