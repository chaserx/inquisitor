FactoryGirl.define do
  factory :cell_phone do
    sequence(:number) {|n| "+1859555121#{n}" }

    trait :verified do
      verified true
    end
  end
end
