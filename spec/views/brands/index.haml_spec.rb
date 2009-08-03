require File.dirname(__FILE__) + '/../../spec_helper'

describe "/brands/index.haml" do
  before do
    brand_98 = mock_model(Brand)
    brand_98.should_receive(:name).and_return("MyString")
    brand_99 = mock_model(Brand)
    brand_99.should_receive(:name).and_return("MyString")

    assigns[:brands] = [brand_98, brand_99]
  end

  it "should render list of brands" do
    render "/brands/index.haml"
  end
end
