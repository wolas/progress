require File.dirname(__FILE__) + '/../../spec_helper'

describe "/teams/index.haml" do
  before do
    team_98 = mock_model(Team)
    team_98.should_receive(:name).and_return("MyString")
    team_99 = mock_model(Team)
    team_99.should_receive(:name).and_return("MyString")

    assigns[:teams] = [team_98, team_99]
  end

  it "should render list of teams" do
    render "/teams/index.haml"
  end
end
