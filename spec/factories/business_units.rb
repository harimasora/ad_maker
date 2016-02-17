FactoryGirl.define do
  factory :business_unit do
    name { Faker::Company.name }
    code { Faker::Number.between(100000,999999) }
    federation_unit_name { Faker::Address.state_abbr }
    city_name { Faker::Address.city }
    kind %w(TUNFranque TUNMaster TUNFranqui).sample
  end

end
