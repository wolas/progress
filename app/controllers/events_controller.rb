class EventsController < ApplicationController
  include EventsHelper
  
  def users
    @users = User.all
    @object = Kernel.eval( params[:object_class] ).find params[:object_id]
  end
  
  def add_user
    event = Event.find params[:id]
    user = User.find params[:user]
    event.users << user
    event.stories.create :changed_data => "atendees", :to => user.name, :creator => current_user
    render(:partial => 'users', :locals => {:object => event})
  end

  def remove_user
    event = Event.find params[:id]
    user = User.find params[:user]
    event.users.delete user
    event.stories.create :changed_data => "atendees", :from => user.name, :creator => current_user
    render(:partial => 'users', :locals => {:object => event})
  end

  # GET /events
  def index
    @user = User.find(params[:user_id])
    @events = @user.events
  end

  # GET /events/1
  def show
    @event = Event.find(params[:id])
    @project = @event.project
    @client = @project.client
  end

  # GET /events/new
  def new
    @project = Project.find(params[:project_id]) if params[:project_id]
    @event = Event.new :project => @project

    render(:partial => 'form', :locals => {:event => @event}) and return if request.xhr?
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @project = @event.project
    render(:partial => 'form', :locals => {:event => @event}) and return if request.xhr?
  end

  # POST /events
  def create
    arrange_date(params[:event])
    @event = Event.new(params[:event])

    if @event.save
      flash[:notice] = 'Event was successfully created.'
      redirect_to @event.project
    else
      @project = @event.project
      @client = @project.client
      render :action => "new"
    end
  end

  # PUT /events/1
  def update
    arrange_date(params[:event])
    @event = Event.find(params[:id])

    if @event.update_attributes(params[:event])
      request.xhr? ? render(:partial => 'list', :locals => {:tasks => Task.find(params[:tasks]), :exclude_completed => params[:exclude_completed]}) : redirect_to(@event)
    else
      @project = @event.project
      @client = @project.client
      render :action => "edit"
    end
  end
  
  def close_interactive_window
    @event = Event.find params[:id]
    @stories = @event.stories.all :limit => 10
  end

  # DELETE /events/1
  def destroy
    @event = Event.find(params[:id])
    @event.destroy
    redirect_to(@event.project)
  end
end
