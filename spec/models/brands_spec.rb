require File.dirname(__FILE__) + '/../spec_helper'

describe Brand do
  before(:each) do
    @brand = Brand.new
  end

  it "should be valid" do
    @brand.should be_valid
  end
end
