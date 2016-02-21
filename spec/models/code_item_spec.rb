require 'spec_helper'

describe CodeItem do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:code_item)).to be_valid
  end
  it 'is invalid without a short description' do
    expect(FactoryGirl.build(:code_item, short_description: nil)).to_not be_valid
  end
  it 'is invalid without a description' do
    expect(FactoryGirl.build(:code_item, description: nil)).to_not be_valid
  end
  it 'short description must be unique' do
    item = FactoryGirl.create(:code_item)
    new_item = item.dup
    expect(new_item).to_not be_valid
  end
  it 'limits short_description to 10 characters' do
    item = FactoryGirl.build(:code_item)
    item.short_description = 'a'*10
    expect(item).to be_valid
    item.short_description = 'b'*11
    expect(item).to_not be_valid
  end
  it 'limits description to 50 characters' do
    item = FactoryGirl.build(:code_item)
    item.description = 'a'*50
    expect(item).to be_valid
    item.description = 'b'*51
    expect(item).to_not be_valid
  end
  it 'limits dependent to 10 characters' do
    item = FactoryGirl.build(:code_item)
    item.dependent = 'a'*10
    expect(item).to be_valid
    item.dependent = 'b'*11
    expect(item).to_not be_valid
  end
end
