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
    account = User.find_by_facebookid(auth_hash['uid'])
    if account
      sign_in account
      redirect_to account
    else
      account = User.create(:email => auth_hash['info']['email'], :name => auth_hash['info']['name'], :facebookid => auth_hash['uid'], :password_digest => "facebook-authorized account")
      if account
        if account.valid?
          sign_in account
          redirect_to account
        else
          render 'new'
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
