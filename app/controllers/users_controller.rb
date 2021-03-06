class UsersController < ApplicationController
  before_filter :signed_in_user, only: [:edit, :update, :destroy]
  before_filter :correct_user, only: [:edit, :update, :destroy]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    if @user.save
      sign_in @user
      redirect_to @user
    else
      render 'new'
    end
  end

  def show
    @user = User.find(params[:id])
  end

  def edit
  end

  def update
    if @user.update_attributes(params[:user])
      flash[:success] = "Profile updated"
      sign_in @user
      redirect_to @user
    else
      render 'edit'
    end
  end

  def destroy
    @user.destroy
    flash[:success] = "User destroyed"
    redirect_to root_path
  end

private

  def signed_in_user
    unless current_account.is_a? User
      redirect_to new_session_url, notice: "Please sign in"
    end
  end

  def correct_user
    @user = User.find_by_id(params[:id])
    unless admin? || current_account == User.find_by_id(params[:id])
      redirect_to root_path
    end
  end
end
