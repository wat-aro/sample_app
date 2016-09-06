require 'rails_helper'

RSpec.describe RelationshipsController do
  let(:user) { create(:user) }
  let(:other_user) { create(:user) }
  before do
    user.follow(other_user)
    @relationship = user.active_relationships.find_by(followed_id: other_user.id)
  end

  it 'create require logged-in user' do
    expect{
      post :create
    }.not_to change(Relationship, :count)
    expect(response).to redirect_to new_user_session_url
  end

  it 'destroy should require logged-in user' do
    expect{
      delete :destroy, id: @relationship
    }.not_to change(Relationship, :count)
    expect(response).to redirect_to new_user_session_url
  end
end
