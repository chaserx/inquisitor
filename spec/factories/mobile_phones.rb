FactoryGirl.define do
  factory :mobile_phone do
    user
    sequence(:number) {|n| "+1859555121#{n}" }

    trait :verified do
      verified true
    end
  end
end
