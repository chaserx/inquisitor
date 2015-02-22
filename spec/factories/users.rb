FactoryGirl.define do
  factory :user do
    email Faker::Internet.email
    pass = Faker::Internet.password(10, 20)
    password pass
    password_confirmation pass
    time_zone 'Eastern Time (US & Canada)'
  end
end
