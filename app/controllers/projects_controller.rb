class ProjectsController < ApplicationController

  # GET /projects
  def index
    @projects = Project.find(:all)
  end

  # GET /projects/1
  def show
    @project = Project.find(params[:id])
    @client = @project.client
  end

  # GET /projects/new
  def new
    client = Client.find(params[:client_id]) if params[:client_id]
    @project = Project.new :client => client
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  def create
    @project = Project.new(params[:project])

    if @project.save
      flash[:notice] = 'Project was successfully created.'
      redirect_to( @project.client ? @project.client : @project )
    else
      render :action => "new"
    end
  end

  # PUT /projects/1
  def update
    @project = Project.find(params[:id])

    params[:project][:user_ids] ||= []

    if @project.update_attributes(params[:project])
      flash[:notice] = 'Project was successfully updated.'
      redirect_to(@project)
    else
      render :action => "edit"
    end
  end

  # DELETE /projects/1
  def destroy
    Project.find(params[:id]).destroy
    redirect_to(projects_url)
  end
end
