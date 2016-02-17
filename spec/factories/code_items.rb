FactoryGirl.define do
  factory :code_item do
    sequence(:short_description) { |n| Faker::Lorem.characters(6) + n.to_s }
    description { Faker::Lorem.word }
  end

end
