FactoryGirl.define do
  factory :question do
    user
    body 'So, whatcha want?'

    trait :not_askable do
      askable false
    end
  end
end
