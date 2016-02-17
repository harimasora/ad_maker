require 'spec_helper'

describe CodeTable do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:code_table)).to be_valid
  end
  it 'is invalid without a name' do
    expect(FactoryGirl.build(:code_table, name: nil)).to_not be_valid
  end
  it 'limits name to 50 characters' do
    item = FactoryGirl.build(:code_table)
    item.name = 'a'*50
    expect(item).to be_valid
    item.name = 'b'*51
    expect(item).to_not be_valid
  end
  it 'limits kind to 10 characters' do
    item = FactoryGirl.build(:code_table)
    item.kind = 'a'*10
    expect(item).to be_valid
    item.kind = 'b'*11
    expect(item).to_not be_valid
  end
end
