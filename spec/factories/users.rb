FactoryGirl.define do
  factory :user do
    email Faker::Internet.safe_email
    pass = Faker::Internet.password(10, 20)
    password pass
    password_confirmation pass
  end
end
