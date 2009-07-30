require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users_stories/new.haml" do
  before do
    @users_stories = mock_model(Users_stories)
    @users_stories.stub!(:new_record?).and_return(true)
    @users_stories.stub!(:user_id).and_return("1")
    @users_stories.stub!(:story_id).and_return("1")
    @users_stories.stub!(:seen).and_return(false)
    assigns[:users_stories] = @users_stories
  end

  it "should render new form" do
    render "/users_stories/new.haml"
    
    response.should have_tag("form[action=?][method=post]", users_stories_path) do
      with_tag("input#users_stories_seen[name=?]", "users_stories[seen]")
    end
  end
end
