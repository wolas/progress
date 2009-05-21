class UsersController < ApplicationController

  def search
    object = Kernel.eval( params[:object_class] ).find params[:object_id]
    users = User.all(:conditions => ["login LIKE ?", "%#{params[:name]}%"]) - object.users
    render( users.empty? ? {:text => "No Users found!"} : {:partial => 'add', :locals => {:users => users, :object => object}})
  end

  def remove_user
    object = Kernel.eval( params[:object_class] ).find params[:object_id]
    user = User.find params[:user]
    object.users.delete user
    render :partial => 'users/manage', :locals => {:object => object }
  end

  def add_user
    object = Kernel.eval( params[:object_class] ).find params[:object_id]
    user = User.find params[:user]
    object.users << user
    render :partial => 'users/manage', :locals => {:object => object }
  end

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      flash[:notice] = "Account registered!"
      redirect_back_or_default account_url
    else
      render :action => :new
    end
  end

  def show
    @show_timeline = true
    @user = @current_user
    @projects = @user.projects.all :conditions => {:closed => false}
    @tasks = @user.tasks.open
    @events = @user.events.in_future
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to account_url
    else
      render :action => :edit
    end
  end

end
