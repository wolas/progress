class TasksController < ApplicationController

  # GET /tasks
  def index
    @user = User.find(params[:user_id])
  end

  # GET /tasks/1
  def show
    @task = Task.find(params[:id])
    @project = @task.project
    @client = @project.client
  end

  # GET /tasks/new
  def new
    @project = Project.find(params[:project_id]) if params[:project_id]
    @task = Task.new :project => @project
    @client = @project.client
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    @project = @task.project
    @client = @project.client
  end

  # POST /tasks
  def create
    @task = Task.new(params[:task])

    if @task.save
      flash[:notice] = 'Task was successfully created.'
      redirect_to @task.project
    else
      @project = @task.project
      @client = @project.client
      render :action => "new"
    end
  end

  # PUT /tasks/1
  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(params[:task])
      request.xhr? ? render(:partial => 'tasks/list_full', :locals => {:list => @task.project.tasks}) : redirect_to(@task)
    else
      @project = @task.project
      @client = @project.client
      render :action => "edit"
    end
  end

  def mark_completed
    @task = Task.find(params[:id])
    @task.update_attributes :completed => true
    flash[:notice] = 'Task has been marked completed.'
    redirect_to :back
  end

  def mark_open
    @task = Task.find(params[:id])
    @task.update_attributes :completed => false
    redirect_to :back
  end

  # DELETE /tasks/1
  def destroy
    Task.find(params[:id]).destroy
    redirect_to(tasks_url)
  end
end
