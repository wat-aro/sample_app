require 'rails_helper'

RSpec.describe "microposts", type: :request do
  before do
    @user = create(:user)
    31.times { @user.microposts.create(content: 'Lorem ipsum') }
  end

  it 'micropost interface' do
    login_as @user
    get root_path
    assert_select 'nav.pagination'

    # 無効な送信
    expect{
      post microposts_path, micropost: { content: '' }
    }.not_to change(Micropost, :count)

    assert_select 'div#error_explanation'
    content = 'This micropost really ties the room together'

    # 有効な送信
    expect{
      post microposts_path, micropost: { content: content }
    }.to change(Micropost, :count).by(1)

    expect(response).to redirect_to root_url
    follow_redirect!
    expect(response.body).to include content

    # 投稿を削除する
    assert_select 'a', text: I18n.t('micropost.delete')
    first_micropost = @user.microposts.paginate(page: 1).first
    expect{
      delete micropost_path(first_micropost)
    }.to change(Micropost, :count).by(-1)

    # 違うユーザーのプロフィールにアクセスする
    get user_path(create(:user))
    assert_select 'a', text: I18n.t('micropost.delete'), count: 0
  end
end
