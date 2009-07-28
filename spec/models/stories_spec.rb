require File.dirname(__FILE__) + '/../spec_helper'

describe Story do
  before(:each) do
    @story = Story.new
  end

  it "should be valid" do
    @story.should be_valid
  end
end
