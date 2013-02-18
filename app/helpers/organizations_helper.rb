module OrganizationsHelper

  def organization?(account)
    account.is_a?(Organization)
  end
end
