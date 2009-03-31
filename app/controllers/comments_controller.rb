class CommentsController < ApplicationController

  # GET /comments
  def index
    @comments = Comment.find(:all)
  end

  # GET /comments/1
  def show
    @comment = Comment.find(params[:id])
  end

  # GET /comments/new
  def new
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
    @comment = Comment.find(params[:id])
  end

  # POST /comments
  def create
    @comment = Comment.new(params[:comment].merge(:user => current_user))

    if @comment.save
      flash[:notice] = 'Comment was successfully created.'
      redirect_to @comment.owner
    else
      render :action => "new"
    end
  end

  # PUT /comments/1
  def update
    @comment = Comment.find(params[:id])

    if @comment.update_attributes(params[:comment])
      flash[:notice] = 'Comment was successfully updated.'
      redirect_to(@comment)
    else
      render :action => "edit"
    end
  end

  # DELETE /comments/1
  def destroy
    Comment.find(params[:id]).destroy
    redirect_to(comments_url)
  end
end
