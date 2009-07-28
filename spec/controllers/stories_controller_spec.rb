require File.dirname(__FILE__) + '/../spec_helper'

describe StoriesController, "#route_for" do

  it "should map { :controller => 'stories', :action => 'index' } to /stories" do
    route_for(:controller => "stories", :action => "index").should == "/stories"
  end
  
  it "should map { :controller => 'stories', :action => 'new' } to /stories/new" do
    route_for(:controller => "stories", :action => "new").should == "/stories/new"
  end
  
  it "should map { :controller => 'stories', :action => 'show', :id => 1 } to /stories/1" do
    route_for(:controller => "stories", :action => "show", :id => 1).should == "/stories/1"
  end
  
  it "should map { :controller => 'stories', :action => 'edit', :id => 1 } to /stories/1/edit" do
    route_for(:controller => "stories", :action => "edit", :id => 1).should == "/stories/1/edit"
  end
  
  it "should map { :controller => 'stories', :action => 'update', :id => 1} to /stories/1" do
    route_for(:controller => "stories", :action => "update", :id => 1).should == "/stories/1"
  end
  
  it "should map { :controller => 'stories', :action => 'destroy', :id => 1} to /stories/1" do
    route_for(:controller => "stories", :action => "destroy", :id => 1).should == "/stories/1"
  end
  
end

describe StoriesController, "handling GET /stories" do

  before do
    @story = mock_model(Story)
    Story.stub!(:find).and_return([@story])
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
  
  it "should find all stories" do
    Story.should_receive(:find).with(:all).and_return([@story])
    do_get
  end
  
  it "should assign the found stories for the view" do
    do_get
    assigns[:stories].should == [@story]
  end
end

describe StoriesController, "handling GET /stories/1" do

  before do
    @story = mock_model(Story)
    Story.stub!(:find).and_return(@story)
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
  
  it "should find the story requested" do
    Story.should_receive(:find).with("1").and_return(@story)
    do_get
  end
  
  it "should assign the found story for the view" do
    do_get
    assigns[:story].should equal(@story)
  end
end

describe StoriesController, "handling GET /stories/new" do

  before do
    @story = mock_model(Story)
    Story.stub!(:new).and_return(@story)
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
  
  it "should create an new story" do
    Story.should_receive(:new).and_return(@story)
    do_get
  end
  
  it "should not save the new story" do
    @story.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new story for the view" do
    do_get
    assigns[:story].should equal(@story)
  end
end

describe StoriesController, "handling GET /stories/1/edit" do

  before do
    @story = mock_model(Story)
    Story.stub!(:find).and_return(@story)
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
  
  it "should find the story requested" do
    Story.should_receive(:find).and_return(@story)
    do_get
  end
  
  it "should assign the found story for the view" do
    do_get
    assigns[:story].should equal(@story)
  end
end

describe StoriesController, "handling POST /stories" do

  before do
    request.env["HTTP_REFERER"] = "/stories/1"
    @story = mock_model(Story, :to_param => "1")
    Story.stub!(:new).and_return(@story)
  end
  
  def post_with_successful_save
    @story.should_receive(:save).and_return(true)
    post :create, :story => {}
  end
  
  def post_with_failed_save
    @story.should_receive(:save).and_return(false)
    post :create, :story => {}
  end
  
  it "should create a new story" do
    Story.should_receive(:new).with({}).and_return(@story)
    post_with_successful_save
  end

  it "should redirect to the new story on successful save" do
    post_with_successful_save
    response.should redirect_to(story_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe StoriesController, "handling PUT /stories/1" do

  before do
    @story = mock_model(Story, :to_param => "1")
    Story.stub!(:find).and_return(@story)
  end
  
  def put_with_successful_update
    @story.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @story.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the story requested" do
    Story.should_receive(:find).with("1").and_return(@story)
    put_with_successful_update
  end

  it "should update the found story" do
    put_with_successful_update
    assigns(:story).should equal(@story)
  end

  it "should assign the found story for the view" do
    put_with_successful_update
    assigns(:story).should equal(@story)
  end

  it "should redirect to the story on successful update" do
    put_with_successful_update
    response.should redirect_to(story_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe StoriesController, "handling DELETE /story/1" do

  before do
    request.env["HTTP_REFERER"] = "/stories"
    @story = mock_model(Story, :destroy => true)
    Story.stub!(:find).and_return(@story)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end
  
  it "should call destroy on the found story" do
    @story.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the stories list" do
    do_delete
    response.should redirect_to(stories_url)
  end
end
