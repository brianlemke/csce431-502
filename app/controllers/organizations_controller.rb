class OrganizationsController < ApplicationController
  before_filter :signed_in_organization,
                only: [:edit, :update, :destroy]
  before_filter :correct_organization,
                only: [:edit, :update, :destroy]

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

  def edit
  end

  def update
    if @organization.update_attributes(params[:organization])
      flash[:success] = "Profile updated"
      sign_in @organization
      redirect_to @organization
    else
      render 'edit'
    end
  end

  def destroy
    @organization.destroy
    flash[:success] = "User destroyed"
    redirect_to root_path
  end

private

  def signed_in_organization
    unless current_account.is_a? Organization
      redirect_to new_session_url, notice: "Please sign in"
    end
  end

  def correct_organization
    @organization = current_account
    unless @organization == Organization.find_by_id(params[:id])
      redirect_to root_path
    end
  end
end
