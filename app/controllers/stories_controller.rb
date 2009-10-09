class StoriesController < ApplicationController

  def show_more
    @object = Kernel.eval(params[:object_class]).find(params[:object_id])
    @mini = params[:mini]
    story = Story.find(params[:id])
    all_stories = @object.is_a?(Project) ? @object.all_stories : @object.stories
    index = all_stories.index story
    @stories = all_stories.slice(index + 1, 10)
    @object.users_stories.find_all_by_story_id(@stories.map(&:id)).each {|story| story.mark_seen } if @object.is_a?(User)
  end

  # GET /stories
  def index
    @user = params[:id] ? User.find(params[:id]) : @current_user
    @stories = @user.stories.slice(0, 10)
    @user.users_stories.slice(0, 10).each {|story| story.mark_seen }
  end

  # GET /stories/1
  def show
    @story = Story.find(params[:id])
  end

  # GET /stories/new
  def new
    @story = Story.new
  end

  # GET /stories/1/edit
  def edit
    @story = Story.find(params[:id])
  end

  # POST /stories
  def create
    @story = Story.new(params[:story])

    if @story.save
      flash[:notice] = 'Story was successfully created.'
      redirect_to :back
    else
      render :action => "new"
    end
  end

  # PUT /stories/1
  def update
    @story = Story.find(params[:id])

    if @story.update_attributes(params[:story])
      flash[:notice] = 'Story was successfully updated.'
      redirect_to(@story)
    else
      render :action => "edit"
    end
  end

  # DELETE /stories/1
  def destroy
    story = Story.find(params[:id])
    parent = story.parent

    if params[:user_id]
      user = User.find params[:user_id]
      user.stories.delete story
    else
      story.destroy
    end
    request.xhr? ? render(:partial => 'list', :locals => {:stories => user.stories}) : redirect_to(stories_url)
  end
end
