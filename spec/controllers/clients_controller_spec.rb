require File.dirname(__FILE__) + '/../spec_helper'

describe ClientsController, "#route_for" do

  it "should map { :controller => 'clients', :action => 'index' } to /clients" do
    route_for(:controller => "clients", :action => "index").should == "/clients"
  end
  
  it "should map { :controller => 'clients', :action => 'new' } to /clients/new" do
    route_for(:controller => "clients", :action => "new").should == "/clients/new"
  end
  
  it "should map { :controller => 'clients', :action => 'show', :id => 1 } to /clients/1" do
    route_for(:controller => "clients", :action => "show", :id => 1).should == "/clients/1"
  end
  
  it "should map { :controller => 'clients', :action => 'edit', :id => 1 } to /clients/1/edit" do
    route_for(:controller => "clients", :action => "edit", :id => 1).should == "/clients/1/edit"
  end
  
  it "should map { :controller => 'clients', :action => 'update', :id => 1} to /clients/1" do
    route_for(:controller => "clients", :action => "update", :id => 1).should == "/clients/1"
  end
  
  it "should map { :controller => 'clients', :action => 'destroy', :id => 1} to /clients/1" do
    route_for(:controller => "clients", :action => "destroy", :id => 1).should == "/clients/1"
  end
  
end

describe ClientsController, "handling GET /clients" do

  before do
    @client = mock_model(Client)
    Client.stub!(:find).and_return([@client])
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
  
  it "should find all clients" do
    Client.should_receive(:find).with(:all).and_return([@client])
    do_get
  end
  
  it "should assign the found clients for the view" do
    do_get
    assigns[:clients].should == [@client]
  end
end

describe ClientsController, "handling GET /clients/1" do

  before do
    @client = mock_model(Client)
    Client.stub!(:find).and_return(@client)
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
  
  it "should find the client requested" do
    Client.should_receive(:find).with("1").and_return(@client)
    do_get
  end
  
  it "should assign the found client for the view" do
    do_get
    assigns[:client].should equal(@client)
  end
end

describe ClientsController, "handling GET /clients/new" do

  before do
    @client = mock_model(Client)
    Client.stub!(:new).and_return(@client)
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
  
  it "should create an new client" do
    Client.should_receive(:new).and_return(@client)
    do_get
  end
  
  it "should not save the new client" do
    @client.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new client for the view" do
    do_get
    assigns[:client].should equal(@client)
  end
end

describe ClientsController, "handling GET /clients/1/edit" do

  before do
    @client = mock_model(Client)
    Client.stub!(:find).and_return(@client)
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
  
  it "should find the client requested" do
    Client.should_receive(:find).and_return(@client)
    do_get
  end
  
  it "should assign the found client for the view" do
    do_get
    assigns[:client].should equal(@client)
  end
end

describe ClientsController, "handling POST /clients" do

  before do
    request.env["HTTP_REFERER"] = "/clients/1"
    @client = mock_model(Client, :to_param => "1")
    Client.stub!(:new).and_return(@client)
  end
  
  def post_with_successful_save
    @client.should_receive(:save).and_return(true)
    post :create, :client => {}
  end
  
  def post_with_failed_save
    @client.should_receive(:save).and_return(false)
    post :create, :client => {}
  end
  
  it "should create a new client" do
    Client.should_receive(:new).with({}).and_return(@client)
    post_with_successful_save
  end

  it "should redirect to the new client on successful save" do
    post_with_successful_save
    response.should redirect_to(client_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe ClientsController, "handling PUT /clients/1" do

  before do
    @client = mock_model(Client, :to_param => "1")
    Client.stub!(:find).and_return(@client)
  end
  
  def put_with_successful_update
    @client.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @client.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the client requested" do
    Client.should_receive(:find).with("1").and_return(@client)
    put_with_successful_update
  end

  it "should update the found client" do
    put_with_successful_update
    assigns(:client).should equal(@client)
  end

  it "should assign the found client for the view" do
    put_with_successful_update
    assigns(:client).should equal(@client)
  end

  it "should redirect to the client on successful update" do
    put_with_successful_update
    response.should redirect_to(client_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe ClientsController, "handling DELETE /client/1" do

  before do
    request.env["HTTP_REFERER"] = "/clients"
    @client = mock_model(Client, :destroy => true)
    Client.stub!(:find).and_return(@client)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end
  
  it "should call destroy on the found client" do
    @client.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the clients list" do
    do_delete
    response.should redirect_to(clients_url)
  end
end
