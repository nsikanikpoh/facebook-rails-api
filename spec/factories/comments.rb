FactoryBot.define do
  factory :comment do
    content { "Comment" }
    user { nil }
    post { nil }
  end
end
