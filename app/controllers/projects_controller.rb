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
    @show_timeline = true
    @project = Project.find(params[:id])
    @object = @project
    @client = @project.client
  end

  # GET /projects/new
  def new
    client = Client.find(params[:client_id]) if params[:client_id]
    @project = Project.new :client => client
    render :partial => 'form', :locals => {:project => @project} if request.xhr?
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    render(:partial => 'form', :locals => {:project => @project}) and return if request.xhr?
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
    @project.attributes = params[:project]
    @project.changes.each_pair { |attribute, values| @project.stories.create :body => "<div class='changed_data'>#{attribute.to_s.humanize}</div> changed from <div class='changed_data'>#{values.first.to_s}</div> to <div class='changed_data'>#{values.last.to_s}</div>", :creator => current_user}

    if @project.save
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

  def users
    @users = User.all
    @object = Kernel.eval( params[:object_class] ).find params[:object_id]
  end

  def add_user
    project = Project.find params[:id]
    user = User.find params[:user]
    project.update_attributes params[:type].to_sym => user
    render(:partial => 'users', :locals => {:object => project})
  end

  def remove_user
    project = Project.find params[:id]
    user = User.find params[:user]
    project.update_attributes params[:type] => nil
    render(:partial => 'users', :locals => {:object => project})
  end

  # DELETE /projects/1
  def destroy
    project = Project.find(params[:id])
    project.destroy
    redirect_to(project.client ? project.client : projects_path)
  end
end
