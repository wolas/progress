class DashboardsController < ApplicationController

  def show
  end

  def get_month
    render :partial => 'calendars/month', :locals => {:object => @current_user}
  end

  def get_week
    date = params[:date] && params[:date].to_date.beginning_of_week || Date.today.beginning_of_week
    week = (date..date.end_of_week).to_a
    render :partial => 'calendars/week', :locals => {:week => week, :events => @current_user.events }
  end

  def get_day
    date = Date.today
    render :partial => 'calendars/day', :locals => {:date => date, :events => @current_user.events, :tasks => @current_user.tasks.open}
  end

  def get_timeline
    render :partial => 'calendars/timeline', :locals => {:height => 500}
  end
end
