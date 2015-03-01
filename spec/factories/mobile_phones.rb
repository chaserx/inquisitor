require 'securerandom'
FactoryGirl.define do
  factory :mobile_phone do
    user
    number { "+1859555" + ('%04d' % SecureRandom.random_number(9999)) }

    trait :verified do
      verified true
    end
  end
end
