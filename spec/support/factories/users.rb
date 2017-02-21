FactoryGirl.define do
  factory :user do
    first_name  { Faker::Name.first_name }
    last_name   { Faker::Name.last_name }
    email       { Faker::Internet.email }
    password    { Faker::Number.number(6) }
  end

  factory :authenticated_user, parent: :user do
    access_token factory: :access_token
  end
end
