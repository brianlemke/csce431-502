module UsersHelper

  def is_user?
    current_account.is_a? User
  end

  def recent_posters(user)
    posters = []
    user.subscriptions.each do |subscription|
      posters.concat subscription.organization.posters
    end
    posters.sort do |a, b|
      return -1 if a.updated_at > b.updated_at
      return 0 if a.updated_at == b.updated_at
      return 1
    end
    posters[0, 20]
  end
end
