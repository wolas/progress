class EventsController < ApplicationController

  def users
    @users = User.all
    @object = Kernel.eval( params[:object_class] ).find params[:object_id]
  end
  
  def add_user
    event = Event.find params[:id]
    user = User.find params[:user]
    event.users << user
    event.stories.create :body => "has <div class='changed_data'>#{user.name}</div> assigned to it</div>", :creator => current_user
    render(:partial => 'users', :locals => {:object => event})
  end

  def remove_user
    event = Event.find params[:id]
    user = User.find params[:user]
    event.users.delete user
    event.stories.create :body => "has removed <div class='changed_data'>#{user.name}</did> from its users</div>", :creator => current_user
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
    p_event = params[:event]
    date = p_event[:date].to_date
    p_event[:'date(1i)'] = date.year.to_s
    p_event[:'date(2i)'] = date.month.to_s
    p_event[:'date(3i)'] = date.day.to_s
    p_event.delete(:date)

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
    @event = Event.find(params[:id])
    p_event = params[:event]
    date = p_event[:date].to_date
    p_event[:'date(1i)'] = date.year.to_s
    p_event[:'date(2i)'] = date.month.to_s
    p_event[:'date(3i)'] = date.day.to_s
    p_event.delete(:date)
    @event.attributes = params[:event]

    @event.changes.each_pair do |attribute, values|
      @event.stories.create :body => "changed <div class='changed_data'>#{attribute.to_s.humanize}</div> from <div class='changed_data'>#{values.first.to_s}</div> to <div class='changed_data'>#{values.last.to_s}</div>", :creator => current_user
    end

    if @event.save
      request.xhr? ? render(:partial => 'list', :locals => {:tasks => Task.find(params[:tasks]), :exclude_completed => params[:exclude_completed]}) : redirect_to(@event)
    else
      @project = @event.project
      @client = @project.client
      render :action => "edit"
    end
  end

  def mark_completed
    @event = Event.find(params[:id])
    @event.update_attributes :completed => true
    flash[:notice] = 'Event has been marked completed.'
    redirect_to :back
  end

  def mark_open
    @event = Event.find(params[:id])
    @event.update_attributes :completed => false
    redirect_to :back
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
