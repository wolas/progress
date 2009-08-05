class UsersController < ApplicationController

  def search
    users = User.all :order => 'surname ASC', :conditions => ["name LIKE ? OR surname LIKE ?", "%#{params[:name]}%", "%#{params[:name]}%"]
    render( users.empty? ? {:text => "No Users found!"} : {:partial => 'drag_list', :locals => {:users => users}})
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
