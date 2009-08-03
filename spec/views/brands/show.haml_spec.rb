require File.dirname(__FILE__) + '/../../spec_helper'

describe "/brands/show.haml" do
  before do
    @brand = mock_model(Brand)
    @brand.stub!(:name).and_return("MyString")

    assigns[:brand] = @brand
  end

  it "should render attributes in <p>" do
    render "/brands/show.haml"
    response.should have_text(/MyString/)
  end
end

