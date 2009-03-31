require File.dirname(__FILE__) + '/../../spec_helper'

describe "/comment/edit.haml" do
  before do
    @comment = mock_model(Comment)
    @comment.stub!(:owner_id).and_return("1")
    @comment.stub!(:owner_type).and_return("MyString")
    @comment.stub!(:body).and_return("MyText")
    @comment.stub!(:automatic).and_return(false)
    @comment.stub!(:user_id).and_return("1")
    assigns[:comment] = @comment
  end

  it "should render edit form" do
    render "/comments/edit.haml"
    
    response.should have_tag("form[action=#{comment_path(@comment)}][method=post]") do
      with_tag('input#comment_owner_type[name=?]', "comment[owner_type]")
      with_tag('textarea#comment_body[name=?]', "comment[body]")
      with_tag('input#comment_automatic[name=?]', "comment[automatic]")
    end
  end
end
