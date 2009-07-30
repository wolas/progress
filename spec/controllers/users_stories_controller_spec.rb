require File.dirname(__FILE__) + '/../spec_helper'

describe UsersStoriesController, "#route_for" do

  it "should map { :controller => 'users_stories', :action => 'index' } to /users_stories" do
    route_for(:controller => "users_stories", :action => "index").should == "/users_stories"
  end
  
  it "should map { :controller => 'users_stories', :action => 'new' } to /users_stories/new" do
    route_for(:controller => "users_stories", :action => "new").should == "/users_stories/new"
  end
  
  it "should map { :controller => 'users_stories', :action => 'show', :id => 1 } to /users_stories/1" do
    route_for(:controller => "users_stories", :action => "show", :id => 1).should == "/users_stories/1"
  end
  
  it "should map { :controller => 'users_stories', :action => 'edit', :id => 1 } to /users_stories/1/edit" do
    route_for(:controller => "users_stories", :action => "edit", :id => 1).should == "/users_stories/1/edit"
  end
  
  it "should map { :controller => 'users_stories', :action => 'update', :id => 1} to /users_stories/1" do
    route_for(:controller => "users_stories", :action => "update", :id => 1).should == "/users_stories/1"
  end
  
  it "should map { :controller => 'users_stories', :action => 'destroy', :id => 1} to /users_stories/1" do
    route_for(:controller => "users_stories", :action => "destroy", :id => 1).should == "/users_stories/1"
  end
  
end

describe UsersStoriesController, "handling GET /users_stories" do

  before do
    @users_stories = mock_model(Users_stories)
    Users_stories.stub!(:find).and_return([@users_stories])
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
  
  it "should find all users_stories" do
    Users_stories.should_receive(:find).with(:all).and_return([@users_stories])
    do_get
  end
  
  it "should assign the found users_stories for the view" do
    do_get
    assigns[:users_stories].should == [@users_stories]
  end
end

describe UsersStoriesController, "handling GET /users_stories/1" do

  before do
    @users_stories = mock_model(Users_stories)
    Users_stories.stub!(:find).and_return(@users_stories)
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
  
  it "should find the users_stories requested" do
    Users_stories.should_receive(:find).with("1").and_return(@users_stories)
    do_get
  end
  
  it "should assign the found users_stories for the view" do
    do_get
    assigns[:users_stories].should equal(@users_stories)
  end
end

describe UsersStoriesController, "handling GET /users_stories/new" do

  before do
    @users_stories = mock_model(Users_stories)
    Users_stories.stub!(:new).and_return(@users_stories)
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
  
  it "should create an new users_stories" do
    Users_stories.should_receive(:new).and_return(@users_stories)
    do_get
  end
  
  it "should not save the new users_stories" do
    @users_stories.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new users_stories for the view" do
    do_get
    assigns[:users_stories].should equal(@users_stories)
  end
end

describe UsersStoriesController, "handling GET /users_stories/1/edit" do

  before do
    @users_stories = mock_model(Users_stories)
    Users_stories.stub!(:find).and_return(@users_stories)
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
  
  it "should find the users_stories requested" do
    Users_stories.should_receive(:find).and_return(@users_stories)
    do_get
  end
  
  it "should assign the found users_stories for the view" do
    do_get
    assigns[:users_stories].should equal(@users_stories)
  end
end

describe UsersStoriesController, "handling POST /users_stories" do

  before do
    request.env["HTTP_REFERER"] = "/users_stories/1"
    @users_stories = mock_model(Users_stories, :to_param => "1")
    Users_stories.stub!(:new).and_return(@users_stories)
  end
  
  def post_with_successful_save
    @users_stories.should_receive(:save).and_return(true)
    post :create, :users_stories => {}
  end
  
  def post_with_failed_save
    @users_stories.should_receive(:save).and_return(false)
    post :create, :users_stories => {}
  end
  
  it "should create a new users_stories" do
    Users_stories.should_receive(:new).with({}).and_return(@users_stories)
    post_with_successful_save
  end

  it "should redirect to the new users_stories on successful save" do
    post_with_successful_save
    response.should redirect_to(users_story_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe UsersStoriesController, "handling PUT /users_stories/1" do

  before do
    @users_stories = mock_model(Users_stories, :to_param => "1")
    Users_stories.stub!(:find).and_return(@users_stories)
  end
  
  def put_with_successful_update
    @users_stories.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @users_stories.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the users_stories requested" do
    Users_stories.should_receive(:find).with("1").and_return(@users_stories)
    put_with_successful_update
  end

  it "should update the found users_stories" do
    put_with_successful_update
    assigns(:users_stories).should equal(@users_stories)
  end

  it "should assign the found users_stories for the view" do
    put_with_successful_update
    assigns(:users_stories).should equal(@users_stories)
  end

  it "should redirect to the users_stories on successful update" do
    put_with_successful_update
    response.should redirect_to(users_story_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe UsersStoriesController, "handling DELETE /users_stories/1" do

  before do
    request.env["HTTP_REFERER"] = "/users_stories"
    @users_stories = mock_model(Users_stories, :destroy => true)
    Users_stories.stub!(:find).and_return(@users_stories)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end
  
  it "should call destroy on the found users_stories" do
    @users_stories.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the users_stories list" do
    do_delete
    response.should redirect_to(usersstories_url)
  end
end
