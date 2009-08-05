require File.dirname(__FILE__) + '/../../spec_helper'

describe "/companies/index.haml" do
  before do
    company_98 = mock_model(Company)
    company_98.should_receive(:name).and_return("MyString")
    company_99 = mock_model(Company)
    company_99.should_receive(:name).and_return("MyString")

    assigns[:companies] = [company_98, company_99]
  end

  it "should render list of companies" do
    render "/companies/index.haml"
  end
end
