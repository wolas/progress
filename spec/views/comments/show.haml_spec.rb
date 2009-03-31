require File.dirname(__FILE__) + '/../../spec_helper'

describe "/comments/show.haml" do
  before do
    @comment = mock_model(Comment)
    @comment.stub!(:owner_id).and_return("1")
    @comment.stub!(:owner_type).and_return("MyString")
    @comment.stub!(:body).and_return("MyText")
    @comment.stub!(:automatic).and_return(false)
    @comment.stub!(:user_id).and_return("1")

    assigns[:comment] = @comment
  end

  it "should render attributes in <p>" do
    render "/comments/show.haml"
    response.should have_text(/MyString/)
    response.should have_text(/MyText/)
    response.should have_text(/als/)
  end
end

