class DashboardsController < ApplicationController

  def show
    @show_timeline = true
    @user = @current_user
    @projects = @user.projects_involved
    @tasks = @user.tasks.open
    @events = @user.events.in_future
  end

end
