require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users_stories/show.haml" do
  before do
    @users_stories = mock_model(Users_stories)
    @users_stories.stub!(:user_id).and_return("1")
    @users_stories.stub!(:story_id).and_return("1")
    @users_stories.stub!(:seen).and_return(false)

    assigns[:users_stories] = @users_stories
  end

  it "should render attributes in <p>" do
    render "/users_stories/show.haml"
    response.should have_text(/als/)
  end
end

