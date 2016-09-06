require 'rails_helper'

RSpec.describe Relationship, type: :model do
  let(:relationship) { Relationship.new(follower_id: 1, followed_id:2) }

  it 'is valid' do
    expect(relationship).to be_valid
  end

  it 'require a follower_id' do
    relationship.follower_id = nil
    relationship.valid?
    expect(relationship.errors[:follower_id]).to include(I18n.t('errors.messages.empty'))
  end

  it 'require a followed_id' do
    relationship.followed_id = nil
    relationship.valid?
    expect(relationship.errors[:followed_id]).to include(I18n.t('errors.messages.empty'))
  end
end
