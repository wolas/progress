require File.dirname(__FILE__) + '/../spec_helper'

describe CompaniesController, "#route_for" do

  it "should map { :controller => 'companies', :action => 'index' } to /companies" do
    route_for(:controller => "companies", :action => "index").should == "/companies"
  end
  
  it "should map { :controller => 'companies', :action => 'new' } to /companies/new" do
    route_for(:controller => "companies", :action => "new").should == "/companies/new"
  end
  
  it "should map { :controller => 'companies', :action => 'show', :id => 1 } to /companies/1" do
    route_for(:controller => "companies", :action => "show", :id => 1).should == "/companies/1"
  end
  
  it "should map { :controller => 'companies', :action => 'edit', :id => 1 } to /companies/1/edit" do
    route_for(:controller => "companies", :action => "edit", :id => 1).should == "/companies/1/edit"
  end
  
  it "should map { :controller => 'companies', :action => 'update', :id => 1} to /companies/1" do
    route_for(:controller => "companies", :action => "update", :id => 1).should == "/companies/1"
  end
  
  it "should map { :controller => 'companies', :action => 'destroy', :id => 1} to /companies/1" do
    route_for(:controller => "companies", :action => "destroy", :id => 1).should == "/companies/1"
  end
  
end

describe CompaniesController, "handling GET /companies" do

  before do
    @company = mock_model(Company)
    Company.stub!(:find).and_return([@company])
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
  
  it "should find all companies" do
    Company.should_receive(:find).with(:all).and_return([@company])
    do_get
  end
  
  it "should assign the found companies for the view" do
    do_get
    assigns[:companies].should == [@company]
  end
end

describe CompaniesController, "handling GET /companies/1" do

  before do
    @company = mock_model(Company)
    Company.stub!(:find).and_return(@company)
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
  
  it "should find the company requested" do
    Company.should_receive(:find).with("1").and_return(@company)
    do_get
  end
  
  it "should assign the found company for the view" do
    do_get
    assigns[:company].should equal(@company)
  end
end

describe CompaniesController, "handling GET /companies/new" do

  before do
    @company = mock_model(Company)
    Company.stub!(:new).and_return(@company)
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
  
  it "should create an new company" do
    Company.should_receive(:new).and_return(@company)
    do_get
  end
  
  it "should not save the new company" do
    @company.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new company for the view" do
    do_get
    assigns[:company].should equal(@company)
  end
end

describe CompaniesController, "handling GET /companies/1/edit" do

  before do
    @company = mock_model(Company)
    Company.stub!(:find).and_return(@company)
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
  
  it "should find the company requested" do
    Company.should_receive(:find).and_return(@company)
    do_get
  end
  
  it "should assign the found company for the view" do
    do_get
    assigns[:company].should equal(@company)
  end
end

describe CompaniesController, "handling POST /companies" do

  before do
    request.env["HTTP_REFERER"] = "/companies/1"
    @company = mock_model(Company, :to_param => "1")
    Company.stub!(:new).and_return(@company)
  end
  
  def post_with_successful_save
    @company.should_receive(:save).and_return(true)
    post :create, :company => {}
  end
  
  def post_with_failed_save
    @company.should_receive(:save).and_return(false)
    post :create, :company => {}
  end
  
  it "should create a new company" do
    Company.should_receive(:new).with({}).and_return(@company)
    post_with_successful_save
  end

  it "should redirect to the new company on successful save" do
    post_with_successful_save
    response.should redirect_to(company_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe CompaniesController, "handling PUT /companies/1" do

  before do
    @company = mock_model(Company, :to_param => "1")
    Company.stub!(:find).and_return(@company)
  end
  
  def put_with_successful_update
    @company.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @company.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the company requested" do
    Company.should_receive(:find).with("1").and_return(@company)
    put_with_successful_update
  end

  it "should update the found company" do
    put_with_successful_update
    assigns(:company).should equal(@company)
  end

  it "should assign the found company for the view" do
    put_with_successful_update
    assigns(:company).should equal(@company)
  end

  it "should redirect to the company on successful update" do
    put_with_successful_update
    response.should redirect_to(company_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe CompaniesController, "handling DELETE /company/1" do

  before do
    request.env["HTTP_REFERER"] = "/companies"
    @company = mock_model(Company, :destroy => true)
    Company.stub!(:find).and_return(@company)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end
  
  it "should call destroy on the found company" do
    @company.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the companies list" do
    do_delete
    response.should redirect_to(companies_url)
  end
end
