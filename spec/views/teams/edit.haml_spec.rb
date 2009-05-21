require File.dirname(__FILE__) + '/../../spec_helper'

describe "/team/edit.haml" do
  before do
    @team = mock_model(Team)
    @team.stub!(:name).and_return("MyString")
    assigns[:team] = @team
  end

  it "should render edit form" do
    render "/teams/edit.haml"
    
    response.should have_tag("form[action=#{team_path(@team)}][method=post]") do
      with_tag('input#team_name[name=?]', "team[name]")
    end
  end
end
