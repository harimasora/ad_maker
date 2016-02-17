require 'spec_helper'

describe BusinessUnit do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:business_unit)).to be_valid
  end
  it 'is invalid without a name' do
    expect(FactoryGirl.build(:business_unit, name: nil)).to_not be_valid
  end
  it 'limits name to 50 characters' do
    item = FactoryGirl.build(:business_unit)
    item.name = 'a'*50
    expect(item).to be_valid
    item.name = 'b'*51
    expect(item).to_not be_valid
  end
  it 'limits code to 8 characters' do
    item = FactoryGirl.build(:business_unit)
    item.code = 'a'*8
    expect(item).to be_valid
    item.code = 'b'*9
    expect(item).to_not be_valid
  end
  it 'limits federation unit to 2 characters' do
    item = FactoryGirl.build(:business_unit)
    item.federation_unit = 'a'*2
    expect(item).to be_valid
    item.federation_unit = 'b'*3
    expect(item).to_not be_valid
  end
  it 'limits city to 50 characters' do
    item = FactoryGirl.build(:business_unit)
    item.city = 'a'*50
    expect(item).to be_valid
    item.city = 'b'*51
    expect(item).to_not be_valid
  end
  it 'limits kind to 10 characters' do
    item = FactoryGirl.build(:business_unit)
    item.kind = 'a'*10
    expect(item).to be_valid
    item.kind = 'b'*11
    expect(item).to_not be_valid
  end
end
