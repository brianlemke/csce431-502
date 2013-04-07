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
    auth_hash = request.env['omniauth.auth']
    account_login = Loginprovider.find_by_provider_and_loginid(auth_hash['provider'], auth_hash['uid'])
    if account_login
      sign_in account_login.user
      redirect_to account_login.user
    else
      account = User.create(:email => auth_hash['info']['email'], :name => auth_hash['info']['name'], :password_digest => "external-authorized account")
      if account
        if account.valid?
          account.loginprovider = Loginprovider.create(:provider => auth_hash['provider'], :loginid => auth_hash['uid'])
          sign_in account
          redirect_to account
        else
          render :text => 'failed'
        end
      else
        render 'new'
      end
    end
  end

  def destroy
    sign_out
    redirect_to home_path
  end
end
