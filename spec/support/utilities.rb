def sign_in(account)
  visit new_session_path
  fill_in "Email",    with: account.email
  fill_in "Password", with: account.password
  click_button "Sign in"
  # Sign in when not using Capybara as well.
  cookies[:login_token] = account.login_token
end
