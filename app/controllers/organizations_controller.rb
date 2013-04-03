class OrganizationsController < ApplicationController
  before_filter :signed_in_organization,
                only: [:edit, :update, :destroy]
  before_filter :correct_organization,
                only: [:edit, :update, :verify, :destroy]
  before_filter :signed_in_user,
                only: [:subscribe, :unsubscribe]

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(params[:organization])
    if @organization.save
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

  def verify
    @organization.update_attribute(:verified, true)
    RegistrationMailer.verified(@organization).deliver
    render 'edit'
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

  def subscribe
    subscription = Subscription.new(organization_id: @organization.id,
                                    user_id: @user.id)
    if subscription.save
      flash[:success] = "Successfully subscribed"
      redirect_to @organization
    else
      flash[:error] = "Error subscribing to organization"
      redirect_to @organization
    end
  end

  def unsubscribe
    subscription = Subscription.where(organization_id: @organization.id,
                                      user_id: @user.id)
    Subscription.destroy_all(organization_id: @organization.id,
                             user_id: @user.id)
    flash[:success] = "Successfully unsubscribed"
    redirect_to @organization
  end

private

  def signed_in_organization
    unless admin? || current_account.is_a?(Organization)
      redirect_to new_session_url, notice: "Please sign in"
    end
  end

  def correct_organization
    @organization = Organization.find_by_id(params[:id])
    unless admin? || @organization == current_account
      redirect_to root_path
    end
  end

  def signed_in_user
    @user = current_account
    @organization = Organization.find_by_id(params[:id])
    unless current_account.is_a?(User)
      redirect_to new_session_url, notice: "Please sign in"
    end
  end
end
