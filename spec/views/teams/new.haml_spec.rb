require File.dirname(__FILE__) + '/../../spec_helper'

describe "/teams/new.haml" do
  before do
    @team = mock_model(Team)
    @team.stub!(:new_record?).and_return(true)
    @team.stub!(:name).and_return("MyString")
    assigns[:team] = @team
  end

  it "should render new form" do
    render "/teams/new.haml"
    
    response.should have_tag("form[action=?][method=post]", teams_path) do
      with_tag("input#team_name[name=?]", "team[name]")
    end
  end
end
