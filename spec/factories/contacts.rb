FactoryBot.define do
  factory :contact do
    sequence(:name) { |n| "Jan#{n}" }
    sequence(:surname) { |n| "Kowalski#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    phone { "+48#{rand(100000000..999999999)}" }
    category { Contact.categories.keys.sample }

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
      phone { "+48 #{rand(100000000..999999999)}" }
    end

    trait :without_phone do
      phone { nil }
    end
  end
end
