class DashboardsController < ApplicationController

  def show
    @show_timeline = true
    @user = @current_user
    @projects = @user.projects_involved :open => true
    @tasks = @user.tasks.open
    @events = @user.events.in_future
  end

end
