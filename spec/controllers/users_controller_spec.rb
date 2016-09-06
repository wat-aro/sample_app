require 'rails_helper'

RSpec.describe UsersController do
  before do
    @user = create(:user)
    @other_user = create(:user)
  end

  it 'redirect index when not logged in' do
    get :index
    expect(response).to redirect_to new_user_session_url
  end

  it 'redirect following when not logged in' do
    get :following, id: @user
    expect(response).to redirect_to new_user_session_url
  end

  it 'redirect follwers when not logged in' do
    get :followers, id: @user
    expect(response).to redirect_to new_user_session_url
  end
end
