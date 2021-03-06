require File.dirname(__FILE__) + '/../../spec_helper'

describe "/role/edit.haml" do
  before do
    @role = mock_model(Role)
    @role.stub!(:name).and_return("MyString")
    assigns[:role] = @role
  end

  it "should render edit form" do
    render "/roles/edit.haml"
    
    response.should have_tag("form[action=#{role_path(@role)}][method=post]") do
      with_tag('input#role_name[name=?]', "role[name]")
    end
  end
end
