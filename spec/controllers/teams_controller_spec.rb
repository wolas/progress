require File.dirname(__FILE__) + '/../spec_helper'

describe TeamsController, "#route_for" do

  it "should map { :controller => 'teams', :action => 'index' } to /teams" do
    route_for(:controller => "teams", :action => "index").should == "/teams"
  end
  
  it "should map { :controller => 'teams', :action => 'new' } to /teams/new" do
    route_for(:controller => "teams", :action => "new").should == "/teams/new"
  end
  
  it "should map { :controller => 'teams', :action => 'show', :id => 1 } to /teams/1" do
    route_for(:controller => "teams", :action => "show", :id => 1).should == "/teams/1"
  end
  
  it "should map { :controller => 'teams', :action => 'edit', :id => 1 } to /teams/1/edit" do
    route_for(:controller => "teams", :action => "edit", :id => 1).should == "/teams/1/edit"
  end
  
  it "should map { :controller => 'teams', :action => 'update', :id => 1} to /teams/1" do
    route_for(:controller => "teams", :action => "update", :id => 1).should == "/teams/1"
  end
  
  it "should map { :controller => 'teams', :action => 'destroy', :id => 1} to /teams/1" do
    route_for(:controller => "teams", :action => "destroy", :id => 1).should == "/teams/1"
  end
  
end

describe TeamsController, "handling GET /teams" do

  before do
    @team = mock_model(Team)
    Team.stub!(:find).and_return([@team])
  end
  
  def do_get
    get :index
  end
  
  it "should be successful" do
    do_get
    response.should be_success
  end

  it "should render index template" do
    do_get
    response.should render_template('index')
  end
  
  it "should find all teams" do
    Team.should_receive(:find).with(:all).and_return([@team])
    do_get
  end
  
  it "should assign the found teams for the view" do
    do_get
    assigns[:teams].should == [@team]
  end
end

describe TeamsController, "handling GET /teams/1" do

  before do
    @team = mock_model(Team)
    Team.stub!(:find).and_return(@team)
  end
  
  def do_get
    get :show, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render show template" do
    do_get
    response.should render_template('show')
  end
  
  it "should find the team requested" do
    Team.should_receive(:find).with("1").and_return(@team)
    do_get
  end
  
  it "should assign the found team for the view" do
    do_get
    assigns[:team].should equal(@team)
  end
end

describe TeamsController, "handling GET /teams/new" do

  before do
    @team = mock_model(Team)
    Team.stub!(:new).and_return(@team)
  end
  
  def do_get
    get :new
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render new template" do
    do_get
    response.should render_template('new')
  end
  
  it "should create an new team" do
    Team.should_receive(:new).and_return(@team)
    do_get
  end
  
  it "should not save the new team" do
    @team.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new team for the view" do
    do_get
    assigns[:team].should equal(@team)
  end
end

describe TeamsController, "handling GET /teams/1/edit" do

  before do
    @team = mock_model(Team)
    Team.stub!(:find).and_return(@team)
  end
  
  def do_get
    get :edit, :id => "1"
  end

  it "should be successful" do
    do_get
    response.should be_success
  end
  
  it "should render edit template" do
    do_get
    response.should render_template('edit')
  end
  
  it "should find the team requested" do
    Team.should_receive(:find).and_return(@team)
    do_get
  end
  
  it "should assign the found team for the view" do
    do_get
    assigns[:team].should equal(@team)
  end
end

describe TeamsController, "handling POST /teams" do

  before do
    request.env["HTTP_REFERER"] = "/teams/1"
    @team = mock_model(Team, :to_param => "1")
    Team.stub!(:new).and_return(@team)
  end
  
  def post_with_successful_save
    @team.should_receive(:save).and_return(true)
    post :create, :team => {}
  end
  
  def post_with_failed_save
    @team.should_receive(:save).and_return(false)
    post :create, :team => {}
  end
  
  it "should create a new team" do
    Team.should_receive(:new).with({}).and_return(@team)
    post_with_successful_save
  end

  it "should redirect to the new team on successful save" do
    post_with_successful_save
    response.should redirect_to(team_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe TeamsController, "handling PUT /teams/1" do

  before do
    @team = mock_model(Team, :to_param => "1")
    Team.stub!(:find).and_return(@team)
  end
  
  def put_with_successful_update
    @team.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @team.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the team requested" do
    Team.should_receive(:find).with("1").and_return(@team)
    put_with_successful_update
  end

  it "should update the found team" do
    put_with_successful_update
    assigns(:team).should equal(@team)
  end

  it "should assign the found team for the view" do
    put_with_successful_update
    assigns(:team).should equal(@team)
  end

  it "should redirect to the team on successful update" do
    put_with_successful_update
    response.should redirect_to(team_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe TeamsController, "handling DELETE /team/1" do

  before do
    request.env["HTTP_REFERER"] = "/teams"
    @team = mock_model(Team, :destroy => true)
    Team.stub!(:find).and_return(@team)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end
  
  it "should call destroy on the found team" do
    @team.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the teams list" do
    do_delete
    response.should redirect_to(teams_url)
  end
end
