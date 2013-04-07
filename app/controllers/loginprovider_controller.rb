class LoginproviderController < ApplicationController
  def create
    auth = request.env["omniauth.auth"]
    user = User.new
    user.name = auth['name']
    user.save!
    flash[:notice] = "Signed in successfully"
    sign_in(:user)
  end

  def destroy
    @authentication = current_user.authentications.find(params[:id])
    @authentication.destroy
    flash[:notice] = "Successfully destroyed authentication."
    redirect_to authentications_url
  end
end