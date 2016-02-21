require 'spec_helper'

describe User do
  it 'has a valid factory' do
    expect(FactoryGirl.create(:user)).to be_valid
  end
  it 'is invalid without a name' do
    expect(FactoryGirl.build(:user, name: nil)).to_not be_valid
  end
  it 'is invalid without a kind' do
    expect(FactoryGirl.build(:user, kind: nil)).to_not be_valid
  end
  it 'limits kind to 10 characters' do
    user = FactoryGirl.build(:user)
    user.kind = 'a'*10
    expect(user).to be_valid
    user.kind = 'b'*11
    expect(user).to_not be_valid
  end
  it 'limits name to 50 characters' do
    user = FactoryGirl.build(:user)
    user.name = 'a'*50
    expect(user).to be_valid
    user.name = 'b'*51
    expect(user).to_not be_valid
  end
  it 'limits situation to 10 characters' do
    user = FactoryGirl.build(:user)
    user.situation = 'a'*10
    expect(user).to be_valid
    user.situation = 'b'*11
    expect(user).to_not be_valid
  end
end
