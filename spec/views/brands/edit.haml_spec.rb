require File.dirname(__FILE__) + '/../../spec_helper'

describe "/brand/edit.haml" do
  before do
    @brand = mock_model(Brand)
    @brand.stub!(:name).and_return("MyString")
    assigns[:brand] = @brand
  end

  it "should render edit form" do
    render "/brands/edit.haml"
    
    response.should have_tag("form[action=#{brand_path(@brand)}][method=post]") do
      with_tag('input#brand_name[name=?]', "brand[name]")
    end
  end
end
