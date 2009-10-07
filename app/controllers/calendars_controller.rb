class CalendarsController < ApplicationController

  before_filter :init_object, :except => [:event_details, :task_details]

  def all_tasks
    tasks = @object.tasks
    tasks = tasks.select{|task| task.open? } if params[:hide_completed_tasks]
    tasks.empty? ? render(:text => "No tasks for #{@object.class} #{@object.name}") : render(:partial => 'tasks/list', :locals => {:tasks => tasks, :exclude_completed => params[:hide_completed_tasks]})
  end
  
  def day
    date = params[:date] ? params[:date].to_date : Date.today
    render :partial => 'calendars/day', :locals => {:date => date, :object => @object}
  end

  def previous_day
    date = params[:current_day].to_date - 1
    render :partial => 'day', :locals => {:date => date, :object => @object}
  end

  def next_day
    date = params[:current_day].to_date + 1
    render :partial => 'day', :locals => {:date => date, :object => @object}
  end

  def week
    date = params[:date] && params[:date].to_date.beginning_of_week || Date.today.beginning_of_week
    week = (date..date.end_of_week).to_a
    render :partial => 'week', :locals => {:week => week, :something => @object }
  end

  def previous_week
    date = params[:current_day].to_date - 7
    week = (date..date.end_of_week).to_a
    render :partial => 'week', :locals => {:week => week, :something => @object }
  end

  def next_week
    date = params[:current_day].to_date + 7
    week = (date..date.end_of_week).to_a
    render :partial => 'week', :locals => {:week => week, :something => @object }
  end

  def month
    date = params[:date] ? params[:date].to_date : Date.today
    render :partial => 'calendars/month', :locals => {:object =>  @object, :date => date}
  end

  def previous_month
    render :partial => 'month', :locals => {:state => params[:state], :date => params[:current_day].to_date.last_month, :object => @object}
  end

  def next_month
    render :partial => 'month', :locals => {:state => params[:state], :date => params[:current_day].to_date.next_month, :object => @object}
  end

  def filter
    render :partial => 'month', :locals => {:object => @object, :date => params[:date].to_date, :state => params[:state]}
  end

  def task_details
    @task = Task.find(params[:id])
    render :partial => 'task', :locals => {:task => @task}
  end

  def event_details
    @event = Event.find(params[:id])
    render :partial => 'event', :locals => {:event => @event}
  end

  def timeline
    render :partial => 'timeline', :locals => {:object => @object, :height => 500}
  end

  def get_timeline

    data = "<data>"
    @object.tasks.each {|task| data += task.to_xml }
    @object.events.each {|event| data += event.to_xml }
    data += "</data>"

    respond_to do |format|
      format.xml { render :text => data }
    end
  end


  protected

  def init_object
    @object = params[:object] ? Kernel.eval(params[:object][:type]).find(params[:object][:id]) : @current_user
  end
end
