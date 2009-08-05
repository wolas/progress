class CompaniesController < ApplicationController
  
  # GET /companies
  def index
    @companies = Company.find(:all)
  end

  # GET /companies/1
  def show
    @company = Company.find(params[:id])
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # GET /companies/1/edit
  def edit
    @company = Company.find(params[:id])
  end

  # POST /companies
  def create
    @company = Company.new(params[:company])

    if @company.save
      flash[:notice] = 'Company was successfully created.'
      redirect_to :back
    else
      render :action => "new"
    end
  end

  # PUT /companies/1
  def update
    @company = Company.find(params[:id])

    if @company.update_attributes(params[:company])
      flash[:notice] = 'Company was successfully updated.'
      redirect_to(@company)
    else
      render :action => "edit"
    end
  end

  # DELETE /companies/1
  def destroy
    Company.find(params[:id]).destroy
    redirect_to(companies_url)
  end
end
