class StoriesController < ApplicationController
  
  # GET /stories
  def index
    @stories = Story.find(:all)
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
    Story.find(params[:id]).destroy
    redirect_to(stories_url)
  end
end
