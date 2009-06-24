class EventsController < ApplicationController

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
    @client = @project.client

    render(:partial => 'form', :locals => {:event => @event}) and return if request.xhr?
  end

  # GET /events/1/edit
  def edit
    @event = Event.find(params[:id])
    @project = @event.project
    @client = @project.client
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

    if @event.update_attributes(params[:event])
      flash[:notice] = 'Event was successfully updated.'
      redirect_to(@event)
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

  # DELETE /events/1
  def destroy
    Event.find(params[:id]).destroy
    redirect_to(events_url)
  end
end
