class Users::Mailer < Devise::Mailer
  helper :application
  include Devise::Controllers::UrlHelpers

  def confirmation_instructions(record, token, opts = {})
    opts[:from] = 'noreply@example.com'
    super
  end

  def reset_password_instructions(record, token, opts = {})
    opts[:from] = 'noreply@example.com'
    super
  end

  def unlock_instructions(record, token, opts = {})
    super
  end
end
