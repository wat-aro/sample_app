require 'rails_helper'

RSpec.describe 'Users home', type: :request do
  before do
    @user = create(:user)
    login_as @user
  end

  it 'home display' do
    get root_url
    assert_template 'static_pages/home'
    assert_template 'shared/_feed'
    assert_select 'h3', text: I18n.t('user.micropost')
    assert_select 'h1', text: @user.name
    expect(response.body).to include @user.following.count.to_s
    expect(response.body).to include @user.followers.count.to_s
    @user.feed.paginate(page: 1).each do |f|
      expect(response.body).to include CGI.escapeHTML(f.content)
    end
  end
end
