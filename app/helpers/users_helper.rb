module UsersHelper

  def user?(account)
    account.is_a?(User)
  end
end
