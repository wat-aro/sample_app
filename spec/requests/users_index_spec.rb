require 'rails_helper'

RSpec.describe 'Users index' do
  before do
    @admin = create(:admin)
    @non_admin = create(:user)
  end

  it 'index as admin including pagination and delete links' do
    login_as @admin
    get users_path
    assert_template 'users/index'
    User.page(1).each do |user|
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: I18n.t('user.delete')
      end
    end
  end

  it 'index as non-admin' do
    login_as @non_admin
    get users_path
    assert_select 'a', text: I18n.t('user.delete'), count: 0
  end
end
