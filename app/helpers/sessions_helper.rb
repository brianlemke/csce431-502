module SessionsHelper

  def sign_in(account)
    cookies.permanent[:login_token] = account.login_token
    self.current_account = account
  end

  def sign_out
    cookies.delete(:login_token)
    self.current_account = nil
  end

  def current_account=(account)
    @current_acount = account
  end

  def current_account
    @current_account ||= User.find_by_login_token(cookies[:login_token])
    @current_account ||= Organization.find_by_login_token(cookies[:login_token])
  end

  def current_account?(account)
    account == current_account
  end
end
