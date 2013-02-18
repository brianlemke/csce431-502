class SessionsController < ApplicationController

  def new
  end

  def create
    account = User.find_by_email(params[:session][:email].downcase)
    account ||= Organization.find_by_email(params[:session][:email].downcase)
    if account && account.authenticate(params[:session][:password])
      sign_in account
      redirect_to account
    else
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
