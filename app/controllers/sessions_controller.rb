class SessionsController < ApplicationController

  def new
  end

  def create
    account = User.find_by_email(params[:session][:email].downcase)
    account ||= Organization.find_by_email(params[:session][:email].downcase)
    if account && account.authenticate(params[:session][:password])
      if account.respond_to?(:verified) && !account.verified
        render 'new'
      else
        sign_in account
        redirect_to account
      end
    else
      render 'new'
    end
  end

  def createExternal
    render 'new'
  end

  def destroy
    sign_out
    redirect_to home_path
  end
end
