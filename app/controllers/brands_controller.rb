class BrandsController < ApplicationController
  
  # GET /brands
  def index
    @brands = Brand.find(:all)
  end

  # GET /brands/1
  def show
    @brand = Brand.find(params[:id])
  end

  # GET /brands/new
  def new
    @brand = Brand.new
  end

  # GET /brands/1/edit
  def edit
    @brand = Brand.find(params[:id])
  end

  # POST /brands
  def create
    @brand = Brand.new(params[:brand])

    if @brand.save
      flash[:notice] = 'Brand was successfully created.'
      redirect_to :back
    else
      render :action => "new"
    end
  end

  # PUT /brands/1
  def update
    @brand = Brand.find(params[:id])

    if @brand.update_attributes(params[:brand])
      flash[:notice] = 'Brand was successfully updated.'
      redirect_to(@brand)
    else
      render :action => "edit"
    end
  end

  # DELETE /brands/1
  def destroy
    Brand.find(params[:id]).destroy
    redirect_to(brands_url)
  end
end
