require File.dirname(__FILE__) + '/../../spec_helper'

describe "/companies/show.haml" do
  before do
    @company = mock_model(Company)
    @company.stub!(:name).and_return("MyString")

    assigns[:company] = @company
  end

  it "should render attributes in <p>" do
    render "/companies/show.haml"
    response.should have_text(/MyString/)
  end
end

