class CalendarsController < ApplicationController

  def show
    @today = Date.today
    @tasks = Task.all
    @events = Event.all
  end

  def previous_month
    klass = Kernel.eval params[:object_type]
    object = klass.find params[:object_id]
    render :partial => 'calendar', :locals => {:some_day => params[:current_day].to_date.last_month, :object => object}
  end

  def next_month
    klass = Kernel.eval params[:object_type]
    object = klass.find params[:object_id]
    render :partial => 'calendar', :locals => {:some_day => params[:current_day].to_date.next_month, :object => object}
  end

  def timeline
    @show_timeline = true
  end

  def task_details
    @task = @current_user.tasks.find(params[:id])
    render :partial => 'task', :locals => {:task => @task}
  end

  def event_details
    @event = @current_user.events.find(params[:id])
    render :partial => 'event', :locals => {:event => @event}
  end

  def get_timeline

    data = "<data>"
    Task.open.each {|task| data += task.to_xml }
    Event.in_future.each {|event| data += event.to_xml }
    data += "</data>"

    respond_to do |format|
      format.xml { render :text => data }
    end
  end

end
