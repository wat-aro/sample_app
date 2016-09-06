require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) do
    User.new(name: 'Example User', email: 'user@example.com',
             password: 'foobar', password_confirmation: 'foobar')
  end

  it 'is valid with a name, email, password and password_confirmation' do
    expect(user).to be_valid
  end

  it 'is invalid without a name' do
    user = User.new(name: ' ')
    user.valid?
    expect(user.errors[:name]).to include(I18n.t('errors.messages.blank'))
  end

  it 'is invalid without a email' do
    user = User.new(email: nil)
    user.valid?
    expect(user.errors[:email]).to include(I18n.t('errors.messages.blank'))
  end

  it 'is invalid with too long name' do
    user = User.new(name: 'a' * 51)
    user.valid?
    expect(user.errors[:name]).to include(I18n.t('errors.messages.too_long', count: 50))
  end

  it 'is invalid with too long email' do
    user = User.new(email: 'a' * 244 + '@example.com')
    user.valid?
    expect(user.errors[:email]).to include(I18n.t('errors.messages.too_long', count: 255))
  end

  describe 'email' do
    it 'accept valid addresses' do
      valid_addresses = %w(user@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn)
      valid_addresses.each do |valid_address|
        user.email = valid_address
        expect(user).to be_valid
      end
    end

    it 'reject invalid address' do
      invalid_addresses = %w(user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com)
      invalid_addresses.each do |invalid_address|
        user.email = invalid_address
        user.valid?
        expect(user.errors[:email]).to include(I18n.t('errors.messages.invalid'))
      end
    end

    it 'is should be unique' do
      duplicate_user = user.dup
      duplicate_user.email = user.email.upcase
      user.save
      duplicate_user.valid?
      expect(duplicate_user.errors[:email]).to include(I18n.t('errors.messages.taken'))
    end
  end

  describe 'password' do
    it 'should be present (nonblank)' do
      user.password = user.password_confirmation = ' ' * 6
      user.valid?
      expect(user.errors[:password]).to include(I18n.t('errors.messages.empty'))
    end

    it 'should have a minimum length' do
      user.password = user.password_confirmation = 'a' * 5
      user.valid?
      expect(user.errors[:password]).to include(I18n.t('errors.messages.too_short', count: 6))
    end
  end

  it 'associated microposts should be destroyed' do
    user = create(:user)
    user.microposts.create(content: 'foo')
    user.microposts.create(content: 'bar')
    # archer has 2 microposts
    expect { user.destroy }.to change { Micropost.count }.by(-2)
  end

  describe 'feed' do
    let(:michael) { create(:user) }
    let(:archer) { create(:user) }
    let(:lana) { create(:user) }

    it "have following user's posts" do
      lana.microposts.each do |post_following|
        expect(michael.feed).to include(post_following)
      end
    end

    it "have my posts" do
      michael.microposts.each do |post_self|
        expect(michael.feed).to include(post_self)
      end
    end

    it "don't have unfollowing user's posts" do
      archer.microposts.each do |posts_unfollowed|
        expect(michael.feed).not_to include(posts_unfollowed)
      end
    end
  end
end
