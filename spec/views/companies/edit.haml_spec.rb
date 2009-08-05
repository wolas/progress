require File.dirname(__FILE__) + '/../../spec_helper'

describe "/company/edit.haml" do
  before do
    @company = mock_model(Company)
    @company.stub!(:name).and_return("MyString")
    assigns[:company] = @company
  end

  it "should render edit form" do
    render "/companies/edit.haml"
    
    response.should have_tag("form[action=#{company_path(@company)}][method=post]") do
      with_tag('input#company_name[name=?]', "company[name]")
    end
  end
end
