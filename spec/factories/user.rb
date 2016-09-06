require 'ffaker'

FactoryGirl.define do
  factory :user do
    name { FFaker::Name.name }
    email { FFaker::Internet.email }
    password 'testtest'
    password_confirmation { password }
    confirmed_at FFaker::Time.date

    factory :admin do
      admin true
    end
  end
end
