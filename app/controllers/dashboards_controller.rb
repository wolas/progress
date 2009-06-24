class DashboardsController < ApplicationController

  def show
    @show_timeline = true
    @user = @current_user
    @projects = @user.projects_involved :open => true
    @tasks = @user.tasks.open
    @events = @user.events.in_future
  end

  def update_task
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])

    render(:partial => 'task_list', :locals => {:tasks => current_user.tasks})
  end

end
