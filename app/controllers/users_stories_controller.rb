class UsersStoriesController < ApplicationController
  
  # GET /users_stories
  def index
    @users_stories = Users_stories.find(:all)
  end

  # GET /users_stories/1
  def show
    @users_stories = Users_stories.find(params[:id])
  end

  # GET /users_stories/new
  def new
    @users_stories = Users_stories.new
  end

  # GET /users_stories/1/edit
  def edit
    @users_stories = Users_stories.find(params[:id])
  end

  # POST /users_stories
  def create
    @users_stories = Users_stories.new(params[:users_stories])

    if @users_stories.save
      flash[:notice] = 'Users_stories was successfully created.'
      redirect_to :back
    else
      render :action => "new"
    end
  end

  # PUT /users_stories/1
  def update
    @users_stories = Users_stories.find(params[:id])

    if @users_stories.update_attributes(params[:users_stories])
      flash[:notice] = 'Users_stories was successfully updated.'
      redirect_to(@users_stories)
    else
      render :action => "edit"
    end
  end

  # DELETE /users_stories/1
  def destroy
    Users_stories.find(params[:id]).destroy
    redirect_to(users_stories_url)
  end
end
