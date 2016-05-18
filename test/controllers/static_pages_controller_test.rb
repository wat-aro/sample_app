require 'test_helper'

class StaticPagesControllerTest < ActionController::TestCase
  test 'should get home' do
    get :home
    assert_response :success
    assert_select 'title', I18n.t('helper.base_title')
  end

  test 'should get help' do
    get :help
    assert_response :success
    assert_select 'title', I18n.t('help_page') + I18n.t('helper.other_title')
  end

  test 'should get about' do
    get :about
    assert_response :success
    assert_select 'title', I18n.t('about_page') + I18n.t('helper.other_title')
  end

  test 'should get contact' do
    get :contact
    assert_response :success
    assert_select 'title', I18n.t('contact_page') + I18n.t('helper.other_title')
  end
end
