class TasksController < ApplicationController

  # GET /tasks
  def index
    @tasks = Task.find(:all)
  end

  # GET /tasks/1
  def show
    @project = Project.find(params[:project_id])
    @task = @project.tasks.find(params[:id])
    @client = @project.client
  end

  # GET /tasks/new
  def new
    project = project.find(params[:project_id]) if params[:project_id]
    @task = Task.new :project => project
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
  end

  # POST /tasks
  def create
    @task = Task.new(params[:task])

    if @task.save
      flash[:notice] = 'Task was successfully created.'
      redirect_to @task.project
    else
      render :action => "new"
    end
  end

  # PUT /tasks/1
  def update
    @task = Task.find(params[:id])

    if @task.update_attributes(params[:task])
      flash[:notice] = 'Task was successfully updated.'
      redirect_to(@task)
    else
      render :action => "edit"
    end
  end

  def mark_completed
    @task = Task.find(params[:id])
    @task.update_attributes :completed => true
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
