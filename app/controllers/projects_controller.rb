class ProjectsController < ApplicationController

  # GET /projects
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @projects = @user.projects
    else
      @projects = Project.all(:order => 'end_date ASC')
    end
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
    @client = @project.client
  end

  # POST /projects
  def create
    @project = Project.new(params[:project])

    if @project.save
      flash[:notice] = 'Project was successfully created.'
      redirect_to @project
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
      @client = @project.client
      render :action => "edit"
    end
  end

  def close
    project = Project.find(params[:id])
    project.update_attributes(:closed => true)
    redirect_to :back
  end

  def reopen
    project = Project.find(params[:id])
    project.update_attributes(:closed => false)
    redirect_to :back
  end

  # DELETE /projects/1
  def destroy
    project = Project.find(params[:id])
    project.destroy
    redirect_to(project.client ? project.client : projects_path)
  end
end
