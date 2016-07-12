require 'test_helper'

class UserMailerTest < ActionMailer::TestCase
  test 'account_activation' do
    user = User.create(name: 'Example User', email: 'example@railstutorial.jp',
                       password: 'foobar', password_confirmation: 'foobar')
    token = user.confirmation_token
    mail = UserMailer.confirmation_instructions(user, token)
    assert_equal I18n.t('devise.mailer.confirmation_instructions.subject'), mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['noreply@example.com'], mail.from
    # body_content = mail.body.encoded.split(/\r\n/).map { |i| Base64.decode64(i) }.join
    body_content = mail.body.to_s
    assert_match user.name, body_content
    assert_match user.confirmation_token, body_content
  end

  test 'password_reset' do
    user = users(:michael)
    token = 'hogehoge'
    mail = UserMailer.reset_password_instructions(user, token)
    assert_equal I18n.t('devise.mailer.reset_password_instructions.subject'), mail.subject
    assert_equal [user.email], mail.to
    assert_equal ['noreply@example.com'], mail.from
    # body_content = mail.body.encoded.split(/\r\n/).map{ |i| Base64.decode64(i)}.join
    body_content = mail.body.to_s
    assert_match token, body_content
  end
end
