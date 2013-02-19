FactoryGirl.define do
  factory :user do
    email "test@example.com"
    password "foobar"
    password_confirmation "foobar"
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
