require File.dirname(__FILE__) + '/../../spec_helper'

describe "/roles/index.haml" do
  before do
    role_98 = mock_model(Role)
    role_98.should_receive(:name).and_return("MyString")
    role_99 = mock_model(Role)
    role_99.should_receive(:name).and_return("MyString")

    assigns[:roles] = [role_98, role_99]
  end

  it "should render list of roles" do
    render "/roles/index.haml"
  end
end
