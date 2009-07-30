class UsersController < ApplicationController

  def search
    object = Kernel.eval( params[:object_class] ).find params[:object_id]
    users = User.all(:conditions => ["login LIKE ?", "%#{params[:name]}%"]) - object.users
    render( users.empty? ? {:text => "No Users found!"} : {:partial => 'manage', :locals => {:users => users, :object => object}})
  end

  def index
    @users = User.all
    render(:partial => 'list', :locals => {:users => @users}) if request.xhr?
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
    @user = @current_user
  end

  def edit
    @user = User.find params[:id]
    render and return unless request.xhr?
    render :partial => params[:password] ? 'password' : 'form', :locals => {:user => @user}
  end

  def update
    @user = @current_user # makes our views "cleaner" and more consistent
    params[:user] ||= {}
    params[:user][:role_ids] ||= []

    if @user.update_attributes(params[:user])
      flash[:notice] = "Account updated!"
      redirect_to profile_url
    else
      @show_password = params[:show_pass]
      render :action => :edit
    end
  end

end
