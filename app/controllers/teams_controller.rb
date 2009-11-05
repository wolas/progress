class TeamsController < ApplicationController
  
  # GET /teams
  def index
    @teams = current_user.created_teams
  end

  # GET /teams/1
  def show
    @team = Team.find(params[:id])
  end

  # GET /teams/new
  def new
    @team = Team.new
    render(:partial => "form", :locals => {:team => @team}) and return if request.xhr?
  end

  # GET /teams/1/edit
  def edit
    @team = Team.find(params[:id])
  end

  # POST /teams
  def create
    @team = Team.new(params[:team].merge(:user => current_user))

    if @team.save
      flash[:notice] = 'Team was successfully created.'
      redirect_to :back
    else
      render :action => "new"
    end
  end

  # PUT /teams/1
  def update
    @team = Team.find(params[:id])

    if @team.update_attributes(params[:team])
      flash[:notice] = 'Team was successfully updated.'
      redirect_to(@team)
    else
      render :action => "edit"
    end
  end

  # DELETE /teams/1
  def destroy
    Team.find(params[:id]).destroy
    redirect_to(teams_url)
  end
end
