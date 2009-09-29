class ClientsController < ApplicationController

  # GET /clients
  def index
    @clients = Client.all :order => 'name ASC'
  end

  # GET /clients/1
  def show
    @client = Client.find(params[:id])
  end

  # GET /clients/new
  def new
    @client = Client.new
    render :partial => 'form', :locals => {:client => @client}
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
    render :partial => "form", :locals => {:client => @client} if request.xhr?
  end

  # POST /clients
  def create
    @client = Client.new(params[:client])

    if @client.save
      flash[:notice] = 'Client was successfully created.'
      redirect_to @client
    else
      render :action => "new"
    end
  end

  # PUT /clients/1
  def update
    @client = Client.find(params[:id])

    if @client.update_attributes(params[:client])
      flash[:notice] = 'Client was successfully updated.'
      redirect_to(@client)
    else
      render :action => "edit"
    end
  end

  # DELETE /clients/1
  def destroy
    Client.find(params[:id]).destroy
    redirect_to(clients_url)
  end
end
