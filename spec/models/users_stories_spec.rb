require File.dirname(__FILE__) + '/../spec_helper'

describe Users_stories do
  before(:each) do
    @users_stories = Users_stories.new
  end

  it "should be valid" do
    @users_stories.should be_valid
  end
end
