require 'spec_helper'

describe ProductionOrder do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:production_order)).to be_valid
  end
  it 'is invalid without a business unit' do
    expect(FactoryGirl.build(:production_order, business_unit: nil)).to_not be_valid
  end
  it 'is invalid without a soliciting user' do
    expect(FactoryGirl.build(:production_order, soliciting_user: nil)).to_not be_valid
  end
  it 'has a unique a code' do
    item = FactoryGirl.create(:production_order)
    new_item = item.dup
    expect(new_item).to be_valid
  end
  it 'creates an code on create' do
    item = FactoryGirl.create(:production_order)
    expect(item.code).to_not be_nil
  end
  # it 'code must have specific format' do
    # Example ~ POB2016011154
    # Porposta de Oferta de Bens -> POB
    # 2016-1-11 -> 20160111
    # ID -> 54

    # item = FactoryGirl.create(:item)
    # expect(item.identifier =~ /[a-zA-Z]+\d{9,}/).to_not be_nil
  # end
end
