require File.dirname(__FILE__) + '/../../spec_helper'

describe "/comments/index.haml" do
  before do
    comment_98 = mock_model(Comment)
    comment_98.should_receive(:owner_id).and_return("1")
    comment_98.should_receive(:owner_type).and_return("MyString")
    comment_98.should_receive(:body).and_return("MyText")
    comment_98.should_receive(:automatic).and_return(false)
    comment_98.should_receive(:user_id).and_return("1")
    comment_99 = mock_model(Comment)
    comment_99.should_receive(:owner_id).and_return("1")
    comment_99.should_receive(:owner_type).and_return("MyString")
    comment_99.should_receive(:body).and_return("MyText")
    comment_99.should_receive(:automatic).and_return(false)
    comment_99.should_receive(:user_id).and_return("1")

    assigns[:comments] = [comment_98, comment_99]
  end

  it "should render list of comments" do
    render "/comments/index.haml"
  end
end
