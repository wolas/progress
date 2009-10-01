class TasksController < ApplicationController

  # GET /tasks
  def index
    @tasks = Task.all :order => 'end_date DESC'
  end

  def manage_users
    params[:user_ids] ||= []
    users = User.find params[:user_ids]
    tasks = users.map{|u| u.tasks }.flatten.uniq.sort_by(&:end_date).reverse
    if tasks.empty?
      text = users.empty? ? "Select users from the right to see their tasks." : "No tasks for #{users.map(&:name).join(', ')}."
      render :text => text
    else
      render :partial => 'list', :locals => {:tasks => tasks}
    end
  end

  # GET /tasks/1
  def show
    @task = Task.find(params[:id])
    @project = @task.project
    @client = @project.client
  end

  # GET /tasks/new
  def new
    @project = Project.find(params[:project_id])
    @task = @project.tasks.new
    render(:partial => 'form', :locals => {:task => @task}) if request.xhr?
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    render(:partial => 'form', :locals => {:task => @task}) if request.xhr?
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

    if @task.update_attributes params[:task]
      request.xhr? ? render(:partial => 'tasks/list', :locals => {:tasks => Task.find(params[:tasks]), :exclude_completed => params[:exclude_completed]}) : redirect_to(@task)
    else
      @project = @task.project
      @client = @project.client
      render :action => "edit"
    end
  end

  def users
    @users = User.all
    @object = Kernel.eval( params[:object_class] ).find params[:object_id]
  end

  def add_user
    task = Task.find params[:id]
    user = User.find params[:user]
    task.send(params[:type].to_sym) << user
    task.stories.create :creator => current_user, :changed_data => params[:type].singularize, :to => user.name
    render(:partial => 'users', :locals => {:object => task})
  end

  def remove_user
    task = Task.find params[:id]
    user = User.find params[:user]
    task.send(params[:type]).delete user
    task.stories.create :creator => current_user, :changed_data => params[:type].singularize, :from => user.name
    render(:partial => 'users', :locals => {:object => task})
  end
  
  def close_interactive_window
    @task = Task.find(params[:id])
    @stories = @task.stories.all :limit => 10
  end

  # DELETE /tasks/1
  def destroy
    @task = Task.find(params[:id])
    @task.destroy
    redirect_to(@task.project)
  end
end
