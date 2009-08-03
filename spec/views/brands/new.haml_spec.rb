require File.dirname(__FILE__) + '/../../spec_helper'

describe "/brands/new.haml" do
  before do
    @brand = mock_model(Brand)
    @brand.stub!(:new_record?).and_return(true)
    @brand.stub!(:name).and_return("MyString")
    assigns[:brand] = @brand
  end

  it "should render new form" do
    render "/brands/new.haml"
    
    response.should have_tag("form[action=?][method=post]", brands_path) do
      with_tag("input#brand_name[name=?]", "brand[name]")
    end
  end
end
