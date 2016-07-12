ActionMailer::Base.perform_deliveries = false

# ユーザー
User.create!(name: 'Example User',
             email: 'example@railstutorial.jp',
             password: 'foobar',
             password_confirmation: 'foobar',
             confirmed_at: 1.hour.ago,
             admin: true)

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"
  password = 'password'
  User.create!(name: name,
               email: email,
               password: password,
               password_confirmation: password,
               confirmed_at: 1.hour.ago)
end

# マイクロポスト
users = User.order(:created_at).take(6)
50.times do
  content = Faker::Lorem.sentence(5)
  users.each { |user| user.microposts.create!(content: content)}
end

# リレーションシップ
users = User.all
user = users.first
following = users[2..50]
followers = users[3..40]
following.each { |followed| user.follow(followed) }
followers.each { |follower| follower.follow(user) }
