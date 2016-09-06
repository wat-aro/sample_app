require 'rails_helper'

RSpec.describe "Following", type: :request do
  before do
    @user = create(:user)
    @other = create(:user)
    @another = create(:user)
    @mallory = create(:user)
    @user.follow(@another)
    @user.follow(@mallory)
    @another.follow(@user)
    @other.follow(@user)
    login_as @user
  end

  it 'following page' do
    get following_user_path(@user)
    expect(@user.following).not_to be_empty
    expect(response.body).to include(@user.following.count.to_s)
    @user.following.each do |user|
      assert_select 'a[href=?]', user_path(user)
    end
  end

  it 'followers page' do
    get followers_user_path(@user)
    expect(@user.following).not_to be_empty
    expect(response.body).to include(@user.followers.count.to_s)
    @user.followers.each do |user|
      assert_select 'a[href=?]', user_path(user)
    end
  end

  it 'follow a user the standard way' do
    expect{
      post relationships_path, followed_id: @other.id
    }.to change(@user.following, :count).by(1)
  end

  it 'follow a user with Ajax' do
    expect{
      xhr :post, relationships_path, followed_id: @other.id
    }.to change(@user.following, :count).by(1)
  end

  it 'unfollow a user the standard way' do
    @user.follow(@other)
    relationship = @user.active_relationships.find_by(followed_id: @other.id)
    expect{
      delete relationship_path(relationship)
    }.to change(@user.following, :count).by(-1)
  end

  it 'unfollow a user with Ajax' do
    @user.follow(@other)
    relationship = @user.active_relationships.find_by(followed_id: @other.id)
    expect{
      xhr :delete, relationship_path(relationship)
    }.to change(@user.following, :count).by(-1)
  end
end
