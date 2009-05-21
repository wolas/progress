require File.dirname(__FILE__) + '/../../spec_helper'

describe "/teams/show.haml" do
  before do
    @team = mock_model(Team)
    @team.stub!(:name).and_return("MyString")

    assigns[:team] = @team
  end

  it "should render attributes in <p>" do
    render "/teams/show.haml"
    response.should have_text(/MyString/)
  end
end

