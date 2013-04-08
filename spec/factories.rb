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
    event_start_date "2010-01-05T12:34:00"
    event_end_date "2010-01-05T14:10:00"
  end
end
