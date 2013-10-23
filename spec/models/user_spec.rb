require 'spec_helper'

describe User do

  it 'should create user with roles = [:user]' do
    user = FactoryGirl.create :user
    user.roles.should == [:user]
  end

  it 'should create admin with roles = [:user, :admin]' do
    user = FactoryGirl.create :admin
    user.roles.should == [:user, :admin]
  end

  it 'should not create user with existing email' do
    FactoryGirl.create :user
    expect {
      user = FactoryGirl.create :user
    }.to raise_exception ActiveRecord::RecordInvalid

  end
end
