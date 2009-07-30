class RolesController < ApplicationController

  def user_roles
    user = User.find params[:id]
    render :partial => 'form_list', :locals => {:user => user}
  end

  # GET /roles
  def index
    @roles = Role.find(:all)
  end

  # GET /roles/1
  def show
    @role = Role.find(params[:id])
  end

  # GET /roles/new
  def new
    @role = Role.new
  end

  # GET /roles/1/edit
  def edit
    @role = Role.find(params[:id])
  end

  # POST /roles
  def create
    @role = Role.new(params[:role])

    if @role.save
      flash[:notice] = 'Role was successfully created.'
      redirect_to :back
    else
      render :action => "new"
    end
  end

  # PUT /roles/1
  def update
    @role = Role.find(params[:id])

    if @role.update_attributes(params[:role])
      flash[:notice] = 'Role was successfully updated.'
      redirect_to(@role)
    else
      render :action => "edit"
    end
  end

  # DELETE /roles/1
  def destroy
    Role.find(params[:id]).destroy
    redirect_to(roles_url)
  end
end
