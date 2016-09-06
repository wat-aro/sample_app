require 'ffaker'

FactoryGirl.define do
  factory :micropost do
    content 'Lorem ipsum'
    created_at { FFaker::Time.date }
    user
  end
end
