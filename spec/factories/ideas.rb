FactoryGirl.define do
  factory :idea do
    association :user, factory: :user
    sequence(:title)        {|n| "#{Faker::Company.bs}-#{n}"}
    sequence(:body)        {|n| "#{Faker::Company.bs}-#{n}"}
  end
end
