require 'rails_helper'

RSpec.describe 'Users profile' do
  include ApplicationHelper
  before do
    @user = create(:user)
    31.times { @user.microposts.create(content: 'Lorem ipsum') }
    login_as @user
  end

  it 'profile display' do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    expect(response.body).to include @user.microposts.count.to_s
    assert_select 'nav.pagination'
    @user.microposts.paginate(page: 1).each do |micropost|
      expect(response.body).to include micropost.content
    end
    assert_select 'strong#following'
    expect(response.body).to include @user.following.count.to_s
    assert_select 'strong#followers'
    expect(response.body).to include @user.followers.count.to_s
  end
end
