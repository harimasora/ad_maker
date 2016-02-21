FactoryGirl.define do
  factory :user do
    name { Faker::Name.name }
    sequence(:email) { |n| Faker::Internet.email("#{name}" + n.to_s) }
    password { Faker::Internet.password(10,16) }
    kind { %w(PUAdminist PUMaster PUFranquea PURepresen PUDesigner PUMarketin).sample }
  end

end
