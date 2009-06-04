class CalendarsController < ApplicationController

  def get_week
    date = params[:date] && params[:date].to_date.beginning_of_week || Date.today.beginning_of_week
    week = (date..date.end_of_week).to_a
    render :partial => 'calendars/week', :locals => {:week => week, :events => @current_user.events }
  end

  def get_day
    date = Date.today
    render :partial => 'calendars/day', :locals => {:date => date, :events => @current_user.events, :tasks => @current_user.tasks.open}
  end

  def day
    @date = params[:date] && params[:date].to_date || Date.today
    @events = @current_user.events.select { |event| event.date.to_date.eql? @date}
    @tasks = @current_user.tasks.open.select { |task| task.happens_in @date }
  end

  def previous_day
    date = params[:current_day].to_date - 1
    tasks = @current_user.tasks.open.select { |task| task.happens_in date }
    events = @current_user.events.select { |event| event.date.to_date.eql? date}
    render :partial => 'day', :locals => {:tasks => tasks, :events => events, :date => date}
  end

  def next_day
    date = params[:current_day].to_date + 1
    tasks = @current_user.tasks.open.select { |task| task.happens_in date }
    events = @current_user.events.select { |event| event.date.to_date.eql? date}
    render :partial => 'day', :locals => {:tasks => tasks, :events => events, :date => date}
  end

  def week
    @date = params[:date] && params[:date].to_date.beginning_of_week || Date.today.beginning_of_week
    @week = (@date..@date.end_of_week).to_a
    @events = @current_user.events
  end

  def previous_week
    date = params[:current_day].to_date - 7
    week = (date..date.end_of_week).to_a
    events = @current_user.events
    render :partial => 'week', :locals => {:events => events, :week => week}
  end

  def next_week
    date = params[:current_day].to_date + 7
    week = (date..date.end_of_week).to_a
    events = @current_user.events
    render :partial => 'week', :locals => {:events => events, :week => week}
  end

  def month
    @today = Date.today
    @tasks = Task.all
    @events = Event.all
  end

  def previous_month
    klass = Kernel.eval params[:object_type]
    object = klass.find params[:object_id]
    render :partial => 'month', :locals => {:state => params[:state], :date => params[:current_day].to_date.last_month, :object => object}
  end

  def next_month
    klass = Kernel.eval params[:object_type]
    object = klass.find params[:object_id]
    render :partial => 'month', :locals => {:state => params[:state], :date => params[:current_day].to_date.next_month, :object => object}
  end

  def filter
    klass = Kernel.eval params[:object_type]
    object = klass.find params[:object_id]
    render :partial => 'month', :locals => {:object => object, :date => params[:date].to_date, :state => params[:state]}
  end

  def get_month
    render :partial => 'calendars/month', :locals => {:object => @current_user}
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
    Event.all.each {|event| data += event.to_xml }
    data += "</data>"

    respond_to do |format|
      format.xml { render :text => data }
    end
  end

end
