FactoryGirl.define do
  factory :comment do
    association :user, factory: :user
    association :idea, factory: :idea
    sequence(:body)        {|n| "#{Faker::Company.bs}-#{n}"}
  end
end
