require File.dirname(__FILE__) + '/../../spec_helper'

describe "/stories/new.haml" do
  before do
    @story = mock_model(Story)
    @story.stub!(:new_record?).and_return(true)
    @story.stub!(:parent_id).and_return("1")
    @story.stub!(:parent_type).and_return("MyString")
    @story.stub!(:body).and_return("MyText")
    @story.stub!(:user_id).and_return("1")
    assigns[:story] = @story
  end

  it "should render new form" do
    render "/stories/new.haml"
    
    response.should have_tag("form[action=?][method=post]", stories_path) do
      with_tag("input#story_parent_type[name=?]", "story[parent_type]")
      with_tag("textarea#story_body[name=?]", "story[body]")
    end
  end
end
