class CalendarsController < ApplicationController

  def index

  end

  def show
    @today = Date.today
    @first = @today.beginning_of_month
    @last = @today.end_of_month

    @month = []

    @first.wday.times { @month << nil }
    @first.upto(@last) { |date| @month << date }
    (42 - @month.size).times { @month << nil }
    @month = @month.in_groups_of(7)
  end

  def task_details
    @task = Task.find(params[:id])
    render :partial => 'task', :locals => {:task => @task}
  end

end
