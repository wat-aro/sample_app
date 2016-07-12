ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/reporters'
Minitest::Reporters.use!

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # # テストユーザーがログインしていればtrueを返す
  # def is_logged_in?
  #   !session[:user_id].nil?
  # end

  # テストユーザーとしてログインする
  def log_in_as(user, options = {})
    password = options[:password] || 'password'
    if integration_test?
      post user_session_path, user: { email: user.email,
                                      password: password }
    else
      sign_in user
    end
  end

  private

  # 統合テスト内ではtrueを返す
  def integration_test?
    defined?(post_via_redirect)
  end

  class ActionController::TestCase
    include Devise::TestHelpers
  end
end
