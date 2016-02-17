FactoryGirl.define do
  factory :production_order do
    association :business_unit
    association :soliciting_user, factory: :user
    name { Faker::Company.name }
    address { Faker::Address.street_address(true)}
    zip { Faker::Number.between(10000,99999).to_s + '-' + Faker::Number.between(100,999).to_s }
    phone1 { Faker::Number.between(10000000000,99999999999) }
    phone2 { Faker::Number.between(10000000000,99999999999) }
    phone3 { Faker::Number.between(10000000000,99999999999) }
    sequence(:email) { |n| Faker::Internet.email(name + n.to_s)}
    website { Faker::Internet.url }
    contact_name { Faker::Name.name}
    contact_phone { Faker::Number.between(10000000000,99999999999) }
    contact_email { Faker::Internet.email(contact_name) }
    facebook { Faker::Internet.url('facebook.com') }
    publicity_text { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraphs(2) }
    youtube_video { Faker::Internet.url('youtube.com') }
    category1 { Faker::Commerce.department(2) }
    category2 { Faker::Commerce.department(2) }
    category3 { Faker::Commerce.department(2) }
    subcategory1 { Faker::Commerce.department(1) }
    subcategory2 { Faker::Commerce.department(1) }
    subcategory3 { Faker::Commerce.department(1) }
  end
end
