class DashboardsController < ApplicationController

  def show
    @show_timeline = true
    @user = @current_user
  end

  def update_task
    @task = Task.find(params[:id])
    @task.update_attributes(params[:task])

    render(:partial => 'task_list', :locals => {:tasks => current_user.tasks})
  end

end
