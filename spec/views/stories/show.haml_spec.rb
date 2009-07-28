require File.dirname(__FILE__) + '/../../spec_helper'

describe "/stories/show.haml" do
  before do
    @story = mock_model(Story)
    @story.stub!(:parent_id).and_return("1")
    @story.stub!(:parent_type).and_return("MyString")
    @story.stub!(:body).and_return("MyText")
    @story.stub!(:user_id).and_return("1")

    assigns[:story] = @story
  end

  it "should render attributes in <p>" do
    render "/stories/show.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
  end
end

