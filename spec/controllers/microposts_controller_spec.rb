require 'rails_helper'

RSpec.describe MicropostsController do
  before do
    @micropost = create(:micropost)
  end

  it 'should redirect create when not logged in' do
    expect{
      post :create, micropost: { content: 'Lorem ipsum'}
    }.not_to change(Micropost, :count)
    expect(response).to redirect_to new_user_session_url
  end

  it 'redirect destroy when not logged in' do
    expect{
      delete :destroy, id: @micropost
    }.not_to change(Micropost, :count)
    expect(response).to redirect_to new_user_session_url
  end

  it 'redirect destroy for wrong micropost' do
    # beforeで@micropostが作られた時点ではまだこのuserはcreateされていないので@micropostの投稿者にはならない
    user = create(:user)
    sign_in user
    expect{
      delete :destroy, id: @micropost
    }.not_to change(Micropost, :count)
    expect(response).to redirect_to root_url
  end
end
