require File.dirname(__FILE__) + '/../spec_helper'

describe BrandsController, "#route_for" do

  it "should map { :controller => 'brands', :action => 'index' } to /brands" do
    route_for(:controller => "brands", :action => "index").should == "/brands"
  end
  
  it "should map { :controller => 'brands', :action => 'new' } to /brands/new" do
    route_for(:controller => "brands", :action => "new").should == "/brands/new"
  end
  
  it "should map { :controller => 'brands', :action => 'show', :id => 1 } to /brands/1" do
    route_for(:controller => "brands", :action => "show", :id => 1).should == "/brands/1"
  end
  
  it "should map { :controller => 'brands', :action => 'edit', :id => 1 } to /brands/1/edit" do
    route_for(:controller => "brands", :action => "edit", :id => 1).should == "/brands/1/edit"
  end
  
  it "should map { :controller => 'brands', :action => 'update', :id => 1} to /brands/1" do
    route_for(:controller => "brands", :action => "update", :id => 1).should == "/brands/1"
  end
  
  it "should map { :controller => 'brands', :action => 'destroy', :id => 1} to /brands/1" do
    route_for(:controller => "brands", :action => "destroy", :id => 1).should == "/brands/1"
  end
  
end

describe BrandsController, "handling GET /brands" do

  before do
    @brand = mock_model(Brand)
    Brand.stub!(:find).and_return([@brand])
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
  
  it "should find all brands" do
    Brand.should_receive(:find).with(:all).and_return([@brand])
    do_get
  end
  
  it "should assign the found brands for the view" do
    do_get
    assigns[:brands].should == [@brand]
  end
end

describe BrandsController, "handling GET /brands/1" do

  before do
    @brand = mock_model(Brand)
    Brand.stub!(:find).and_return(@brand)
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
  
  it "should find the brand requested" do
    Brand.should_receive(:find).with("1").and_return(@brand)
    do_get
  end
  
  it "should assign the found brand for the view" do
    do_get
    assigns[:brand].should equal(@brand)
  end
end

describe BrandsController, "handling GET /brands/new" do

  before do
    @brand = mock_model(Brand)
    Brand.stub!(:new).and_return(@brand)
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
  
  it "should create an new brand" do
    Brand.should_receive(:new).and_return(@brand)
    do_get
  end
  
  it "should not save the new brand" do
    @brand.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new brand for the view" do
    do_get
    assigns[:brand].should equal(@brand)
  end
end

describe BrandsController, "handling GET /brands/1/edit" do

  before do
    @brand = mock_model(Brand)
    Brand.stub!(:find).and_return(@brand)
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
  
  it "should find the brand requested" do
    Brand.should_receive(:find).and_return(@brand)
    do_get
  end
  
  it "should assign the found brand for the view" do
    do_get
    assigns[:brand].should equal(@brand)
  end
end

describe BrandsController, "handling POST /brands" do

  before do
    request.env["HTTP_REFERER"] = "/brands/1"
    @brand = mock_model(Brand, :to_param => "1")
    Brand.stub!(:new).and_return(@brand)
  end
  
  def post_with_successful_save
    @brand.should_receive(:save).and_return(true)
    post :create, :brand => {}
  end
  
  def post_with_failed_save
    @brand.should_receive(:save).and_return(false)
    post :create, :brand => {}
  end
  
  it "should create a new brand" do
    Brand.should_receive(:new).with({}).and_return(@brand)
    post_with_successful_save
  end

  it "should redirect to the new brand on successful save" do
    post_with_successful_save
    response.should redirect_to(brand_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe BrandsController, "handling PUT /brands/1" do

  before do
    @brand = mock_model(Brand, :to_param => "1")
    Brand.stub!(:find).and_return(@brand)
  end
  
  def put_with_successful_update
    @brand.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @brand.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the brand requested" do
    Brand.should_receive(:find).with("1").and_return(@brand)
    put_with_successful_update
  end

  it "should update the found brand" do
    put_with_successful_update
    assigns(:brand).should equal(@brand)
  end

  it "should assign the found brand for the view" do
    put_with_successful_update
    assigns(:brand).should equal(@brand)
  end

  it "should redirect to the brand on successful update" do
    put_with_successful_update
    response.should redirect_to(brand_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe BrandsController, "handling DELETE /brand/1" do

  before do
    request.env["HTTP_REFERER"] = "/brands"
    @brand = mock_model(Brand, :destroy => true)
    Brand.stub!(:find).and_return(@brand)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end
  
  it "should call destroy on the found brand" do
    @brand.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the brands list" do
    do_delete
    response.should redirect_to(brands_url)
  end
end
