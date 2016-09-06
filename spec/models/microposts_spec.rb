require 'rails_helper'

RSpec.describe Micropost, type: :model do
  let(:user) { create(:user) }
  let(:micropost) { user.microposts.build(content: 'Lorem ipsum')}

  it 'is valid' do
    expect(micropost).to be_valid
  end

  it 'is invalid without a user id' do
    micropost.user_id = nil
    micropost.valid?
    expect(micropost.errors[:user_id]).to include(I18n.t('errors.messages.blank'))
  end

  it 'is invalid without a content' do
    micropost.content = ' '
    micropost.valid?
    expect(micropost.errors[:content]).to include(I18n.t('errors.messages.blank'))
  end

  describe 'content' do
    it 'is at most 140 characters' do
      micropost.content = 'a' * 141
      micropost.valid?
      expect(micropost.errors[:content]).to include(I18n.t('errors.messages.too_long', count: 140))
    end
  end

  describe 'order' do
    it 'is most recent first' do
      expect(user.microposts.create(content: 'Lorem ipsum')).to eq Micropost.first
    end
  end
end
