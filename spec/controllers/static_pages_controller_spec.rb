require 'rails_helper'

RSpec.describe StaticPagesController do

  render_views

  it 'get home' do
    get :home
    expect(response).to have_http_status(:success)
    assert_select 'title', I18n.t('helper.base_title')
  end

  it 'get help' do
    get :help
    expect(response).to have_http_status(:success)
    assert_select 'title', I18n.t('help_page') + I18n.t('helper.other_title')
  end

  it 'get about' do
    get :about
    expect(response).to have_http_status(:success)
    assert_select 'title', I18n.t('about_page') + I18n.t('helper.other_title')
  end

  it 'get contact' do
    get :contact
    expect(response).to have_http_status(:success)
    assert_select 'title', I18n.t('contact_page') + I18n.t('helper.other_title')
  end
end
