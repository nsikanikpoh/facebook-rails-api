FactoryBot.define do
  factory :profile do
    user_id { 1 }
    birthday { '1996-05-17' }
    location { 'Abuja, Nig' }
    gender   { 'Male' }
    bio      { 'A short blgahgs about me' }
  end
end
