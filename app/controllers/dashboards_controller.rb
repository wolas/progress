class DashboardsController < ApplicationController

  def show
    @show_timeline = true
    @user = @current_user
  end

  def update_task
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])

    render(:partial => 'tasks/list', :locals => {:tasks => current_user.tasks, :exclude_completed => true})
  end

end
