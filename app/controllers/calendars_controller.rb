class CalendarsController < ApplicationController

  def show
    respond_to do |format|
      format.html
      format.xml { render :text => "caca"}
    end
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
    Task.all.each {|task| data += task.to_xml }
    Event.all.each {|event| data += event.to_xml }
    data += "</data>"

    respond_to do |format|
      format.xml { render :text => data }
    end
  end

end
