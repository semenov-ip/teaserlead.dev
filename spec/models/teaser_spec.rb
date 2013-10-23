require 'spec_helper'

describe Teaser do

  it "should create teaser with text and image" do
    teaser = FactoryGirl.create :teaser
    teaser.should be_persisted
  end
end
