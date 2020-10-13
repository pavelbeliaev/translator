FactoryBot.define do
  factory :user do
    email                 { 'john@doe.com' }
    password              { 'password' }
    password_confirmation { 'password' }
    confirmed_at          { Time.now }
    account

    trait :bilbo do
      email                 { 'bilbo@shire.com' }
      password              { 'adventure' }
      password_confirmation { 'adventure' }
    end

    trait :not_confirmed do
      confirmed_at { nil }
    end
  end
end