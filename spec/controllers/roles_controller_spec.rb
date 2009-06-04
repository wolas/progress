require File.dirname(__FILE__) + '/../spec_helper'

describe RolesController, "#route_for" do

  it "should map { :controller => 'roles', :action => 'index' } to /roles" do
    route_for(:controller => "roles", :action => "index").should == "/roles"
  end
  
  it "should map { :controller => 'roles', :action => 'new' } to /roles/new" do
    route_for(:controller => "roles", :action => "new").should == "/roles/new"
  end
  
  it "should map { :controller => 'roles', :action => 'show', :id => 1 } to /roles/1" do
    route_for(:controller => "roles", :action => "show", :id => 1).should == "/roles/1"
  end
  
  it "should map { :controller => 'roles', :action => 'edit', :id => 1 } to /roles/1/edit" do
    route_for(:controller => "roles", :action => "edit", :id => 1).should == "/roles/1/edit"
  end
  
  it "should map { :controller => 'roles', :action => 'update', :id => 1} to /roles/1" do
    route_for(:controller => "roles", :action => "update", :id => 1).should == "/roles/1"
  end
  
  it "should map { :controller => 'roles', :action => 'destroy', :id => 1} to /roles/1" do
    route_for(:controller => "roles", :action => "destroy", :id => 1).should == "/roles/1"
  end
  
end

describe RolesController, "handling GET /roles" do

  before do
    @role = mock_model(Role)
    Role.stub!(:find).and_return([@role])
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
  
  it "should find all roles" do
    Role.should_receive(:find).with(:all).and_return([@role])
    do_get
  end
  
  it "should assign the found roles for the view" do
    do_get
    assigns[:roles].should == [@role]
  end
end

describe RolesController, "handling GET /roles/1" do

  before do
    @role = mock_model(Role)
    Role.stub!(:find).and_return(@role)
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
  
  it "should find the role requested" do
    Role.should_receive(:find).with("1").and_return(@role)
    do_get
  end
  
  it "should assign the found role for the view" do
    do_get
    assigns[:role].should equal(@role)
  end
end

describe RolesController, "handling GET /roles/new" do

  before do
    @role = mock_model(Role)
    Role.stub!(:new).and_return(@role)
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
  
  it "should create an new role" do
    Role.should_receive(:new).and_return(@role)
    do_get
  end
  
  it "should not save the new role" do
    @role.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new role for the view" do
    do_get
    assigns[:role].should equal(@role)
  end
end

describe RolesController, "handling GET /roles/1/edit" do

  before do
    @role = mock_model(Role)
    Role.stub!(:find).and_return(@role)
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
  
  it "should find the role requested" do
    Role.should_receive(:find).and_return(@role)
    do_get
  end
  
  it "should assign the found role for the view" do
    do_get
    assigns[:role].should equal(@role)
  end
end

describe RolesController, "handling POST /roles" do

  before do
    request.env["HTTP_REFERER"] = "/roles/1"
    @role = mock_model(Role, :to_param => "1")
    Role.stub!(:new).and_return(@role)
  end
  
  def post_with_successful_save
    @role.should_receive(:save).and_return(true)
    post :create, :role => {}
  end
  
  def post_with_failed_save
    @role.should_receive(:save).and_return(false)
    post :create, :role => {}
  end
  
  it "should create a new role" do
    Role.should_receive(:new).with({}).and_return(@role)
    post_with_successful_save
  end

  it "should redirect to the new role on successful save" do
    post_with_successful_save
    response.should redirect_to(role_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe RolesController, "handling PUT /roles/1" do

  before do
    @role = mock_model(Role, :to_param => "1")
    Role.stub!(:find).and_return(@role)
  end
  
  def put_with_successful_update
    @role.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @role.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the role requested" do
    Role.should_receive(:find).with("1").and_return(@role)
    put_with_successful_update
  end

  it "should update the found role" do
    put_with_successful_update
    assigns(:role).should equal(@role)
  end

  it "should assign the found role for the view" do
    put_with_successful_update
    assigns(:role).should equal(@role)
  end

  it "should redirect to the role on successful update" do
    put_with_successful_update
    response.should redirect_to(role_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe RolesController, "handling DELETE /role/1" do

  before do
    request.env["HTTP_REFERER"] = "/roles"
    @role = mock_model(Role, :destroy => true)
    Role.stub!(:find).and_return(@role)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end
  
  it "should call destroy on the found role" do
    @role.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the roles list" do
    do_delete
    response.should redirect_to(roles_url)
  end
end
