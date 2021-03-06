class ProjectsController < ApplicationController
  require 'tempfile'

  def download
    projects = Project.all :conditions => {:closed => false}
    file = Tempfile.new "all.txt"
    
    title =  "Progress on #{Date.today.to_s}\n"
    file.write title + ("=" * title.length) + "\n\n"
    
    projects.each { |project| file.write project.to_s }
    
    file.close
    send_file file.path
  end
  
  def search
    projects = Project.all :order => 'name ASC', :conditions => ["name LIKE ?", "%#{params[:name]}%"]
    render( projects.empty? ? {:text => "No Projects with name #{params[:name]} found!"} : {:partial => "list_complete", :locals => {:projects => projects}})
  end
  
  # GET /projects
  def index
    if params[:user_id]
      @user = User.find(params[:user_id])
      @projects = @user.projects
    else
      @projects = Project.all
    end
  end

  # GET /projects/1
  def show
    @show_timeline = true
    @project = Project.find(params[:id])
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
    
    if @project.update_attributes params[:project]
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
    @object = Kernel.eval( params[:object_class] ).find params[:object_id]
  end

  def add_user
    user = User.find(params[:user])
    @object = Project.find params[:id]
    @object.update_attributes params[:type].to_sym => user
    Emailer.deliver_project_assigned user, @object, params[:type]
  end

  def remove_user
    @object = Project.find params[:id]
    @object.update_attributes params[:type] => nil
    render :partial => 'users', :locals => {:object => @object}
  end
  
  def close_interactive_window
    @project = Project.find params[:id]
    @stories = @project.all_stories.slice(0, 10)
  end

  # DELETE /projects/1
  def destroy
    project = Project.find(params[:id])
    project.destroy
    redirect_to(project.client ? project.client : projects_path)
  end
end
