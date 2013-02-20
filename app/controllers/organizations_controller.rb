class OrganizationsController < ApplicationController

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(params[:organization])
    if @organization.save
      sign_in @organization
      redirect_to @organization
    else
      render 'new'
    end
  end

  def show
    @organization = Organization.find(params[:id])
  end
end
