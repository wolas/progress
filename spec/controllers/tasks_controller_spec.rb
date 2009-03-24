require File.dirname(__FILE__) + '/../spec_helper'

describe TasksController, "#route_for" do

  it "should map { :controller => 'tasks', :action => 'index' } to /tasks" do
    route_for(:controller => "tasks", :action => "index").should == "/tasks"
  end
  
  it "should map { :controller => 'tasks', :action => 'new' } to /tasks/new" do
    route_for(:controller => "tasks", :action => "new").should == "/tasks/new"
  end
  
  it "should map { :controller => 'tasks', :action => 'show', :id => 1 } to /tasks/1" do
    route_for(:controller => "tasks", :action => "show", :id => 1).should == "/tasks/1"
  end
  
  it "should map { :controller => 'tasks', :action => 'edit', :id => 1 } to /tasks/1/edit" do
    route_for(:controller => "tasks", :action => "edit", :id => 1).should == "/tasks/1/edit"
  end
  
  it "should map { :controller => 'tasks', :action => 'update', :id => 1} to /tasks/1" do
    route_for(:controller => "tasks", :action => "update", :id => 1).should == "/tasks/1"
  end
  
  it "should map { :controller => 'tasks', :action => 'destroy', :id => 1} to /tasks/1" do
    route_for(:controller => "tasks", :action => "destroy", :id => 1).should == "/tasks/1"
  end
  
end

describe TasksController, "handling GET /tasks" do

  before do
    @task = mock_model(Task)
    Task.stub!(:find).and_return([@task])
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
  
  it "should find all tasks" do
    Task.should_receive(:find).with(:all).and_return([@task])
    do_get
  end
  
  it "should assign the found tasks for the view" do
    do_get
    assigns[:tasks].should == [@task]
  end
end

describe TasksController, "handling GET /tasks/1" do

  before do
    @task = mock_model(Task)
    Task.stub!(:find).and_return(@task)
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
  
  it "should find the task requested" do
    Task.should_receive(:find).with("1").and_return(@task)
    do_get
  end
  
  it "should assign the found task for the view" do
    do_get
    assigns[:task].should equal(@task)
  end
end

describe TasksController, "handling GET /tasks/new" do

  before do
    @task = mock_model(Task)
    Task.stub!(:new).and_return(@task)
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
  
  it "should create an new task" do
    Task.should_receive(:new).and_return(@task)
    do_get
  end
  
  it "should not save the new task" do
    @task.should_not_receive(:save)
    do_get
  end
  
  it "should assign the new task for the view" do
    do_get
    assigns[:task].should equal(@task)
  end
end

describe TasksController, "handling GET /tasks/1/edit" do

  before do
    @task = mock_model(Task)
    Task.stub!(:find).and_return(@task)
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
  
  it "should find the task requested" do
    Task.should_receive(:find).and_return(@task)
    do_get
  end
  
  it "should assign the found task for the view" do
    do_get
    assigns[:task].should equal(@task)
  end
end

describe TasksController, "handling POST /tasks" do

  before do
    request.env["HTTP_REFERER"] = "/tasks/1"
    @task = mock_model(Task, :to_param => "1")
    Task.stub!(:new).and_return(@task)
  end
  
  def post_with_successful_save
    @task.should_receive(:save).and_return(true)
    post :create, :task => {}
  end
  
  def post_with_failed_save
    @task.should_receive(:save).and_return(false)
    post :create, :task => {}
  end
  
  it "should create a new task" do
    Task.should_receive(:new).with({}).and_return(@task)
    post_with_successful_save
  end

  it "should redirect to the new task on successful save" do
    post_with_successful_save
    response.should redirect_to(task_url("1"))
  end

  it "should re-render 'new' on failed save" do
    post_with_failed_save
    response.should render_template('new')
  end
end

describe TasksController, "handling PUT /tasks/1" do

  before do
    @task = mock_model(Task, :to_param => "1")
    Task.stub!(:find).and_return(@task)
  end
  
  def put_with_successful_update
    @task.should_receive(:update_attributes).and_return(true)
    put :update, :id => "1"
  end
  
  def put_with_failed_update
    @task.should_receive(:update_attributes).and_return(false)
    put :update, :id => "1"
  end
  
  it "should find the task requested" do
    Task.should_receive(:find).with("1").and_return(@task)
    put_with_successful_update
  end

  it "should update the found task" do
    put_with_successful_update
    assigns(:task).should equal(@task)
  end

  it "should assign the found task for the view" do
    put_with_successful_update
    assigns(:task).should equal(@task)
  end

  it "should redirect to the task on successful update" do
    put_with_successful_update
    response.should redirect_to(task_url("1"))
  end

  it "should re-render 'edit' on failed update" do
    put_with_failed_update
    response.should render_template('edit')
  end
end

describe TasksController, "handling DELETE /task/1" do

  before do
    request.env["HTTP_REFERER"] = "/tasks"
    @task = mock_model(Task, :destroy => true)
    Task.stub!(:find).and_return(@task)
  end
  
  def do_delete
    delete :destroy, :id => "1"
  end
  
  it "should call destroy on the found task" do
    @task.should_receive(:destroy)
    do_delete
  end
  
  it "should redirect to the tasks list" do
    do_delete
    response.should redirect_to(tasks_url)
  end
end
