FactoryBot.define do
  factory :user do
    first_name { 'Mreda' }
    last_name { 'Parker' }
    email { 'gh@email.com' }
    password { 'password' }
  end

  factory :random_user, class: User do
    first_name { Faker::Name.first_name }
    last_name  { Faker::Name.last_name }
    email      { Faker::Internet.safe_email }
    password   { 'password' }
  end
end
