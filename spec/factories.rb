FactoryGirl.define do
  factory :user do
    name "Example User"
    email "test@example.com"
    password "foobar"
    password_confirmation "foobar"

    factory :admin do
      admin true
    end
  end

  factory :organization do
    email "organization@example.com"
    password "foobar"
    password_confirmation "foobar"
    name "Test Organization"
    description "This is a fake organization"
  end

  factory :poster do
    file "dummy.jpg"
    title "Test Poster"
    organization
  end
end
