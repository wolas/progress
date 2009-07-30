require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users_stories/index.haml" do
  before do
    users_stories_98 = mock_model(Users_stories)
    users_stories_98.should_receive(:user_id).and_return("1")
    users_stories_98.should_receive(:story_id).and_return("1")
    users_stories_98.should_receive(:seen).and_return(false)
    users_stories_99 = mock_model(Users_stories)
    users_stories_99.should_receive(:user_id).and_return("1")
    users_stories_99.should_receive(:story_id).and_return("1")
    users_stories_99.should_receive(:seen).and_return(false)

    assigns[:users_stories] = [users_stories_98, users_stories_99]
  end

  it "should render list of users_stories" do
    render "/users_stories/index.haml"
  end
end
