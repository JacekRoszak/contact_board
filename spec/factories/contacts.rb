FactoryBot.define do
  factory :contact do
    name { Faker::Name.first_name }
    surname { Faker::Name.last_name }
    email { Faker::Internet.unique.email }
    phone { Faker::PhoneNumber.phone_number }
    category { :family }

    trait :family do
      category { :family }
    end

    trait :friends do
      category { :friends }
    end

    trait :work do
      category { :work }
    end

    trait :with_polish_phone do
      phone { "+48 #{Faker::Number.number(digits: 9)}" }
    end

    trait :without_phone do
      phone { nil }
    end
  end
end
