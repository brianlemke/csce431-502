module OrganizationsHelper
  def is_organization?
    current_account.is_a? Organization
  end

  def is_subscribed?(organization)
    if current_account.is_a? User
      Subscription.where("user_id = ? AND organization_id = ?",
                         current_account.id, organization.id).present?
    else
      return false
    end
  end
end
