require File.dirname(__FILE__) + '/../../spec_helper'

describe "/stories/index.haml" do
  before do
    story_98 = mock_model(Story)
    story_98.should_receive(:parent_id).and_return("1")
    story_98.should_receive(:parent_type).and_return("MyString")
    story_98.should_receive(:body).and_return("MyText")
    story_98.should_receive(:user_id).and_return("1")
    story_99 = mock_model(Story)
    story_99.should_receive(:parent_id).and_return("1")
    story_99.should_receive(:parent_type).and_return("MyString")
    story_99.should_receive(:body).and_return("MyText")
    story_99.should_receive(:user_id).and_return("1")

    assigns[:stories] = [story_98, story_99]
  end

  it "should render list of stories" do
    render "/stories/index.haml"
  end
end
