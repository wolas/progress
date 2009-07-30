require File.dirname(__FILE__) + '/../../spec_helper'

describe "/users_stories/edit.haml" do
  before do
    @users_stories = mock_model(Users_stories)
    @users_stories.stub!(:user_id).and_return("1")
    @users_stories.stub!(:story_id).and_return("1")
    @users_stories.stub!(:seen).and_return(false)
    assigns[:users_stories] = @users_stories
  end

  it "should render edit form" do
    render "/users_stories/edit.haml"
    
    response.should have_tag("form[action=#{users_story_path(@users_stories)}][method=post]") do
      with_tag('input#users_stories_seen[name=?]', "users_stories[seen]")
    end
  end
end
