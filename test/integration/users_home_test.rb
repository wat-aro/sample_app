require 'test_helper'

class UsersHomeTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    log_in_as @user
  end

  test 'home display' do
    get root_url
    assert_template 'static_pages/home'
    assert_template 'shared/_feed'
    assert_select 'h3', text: I18n.t('user.micropost')
    assert_select 'h1', text: @user.name
    assert_match @user.following.count.to_s, response.body
    assert_match @user.followers.count.to_s, response.body
    @user.feed.paginate(page: 1).each do |f|
      assert_match CGI.escapeHTML(f.content), response.body
    end
  end
end
