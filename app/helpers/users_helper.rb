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
      if a.updated_at > b.updated_at
        -1
      elsif a.updated_at == b.updated_at
        0
      else
        1
      end
    end
    posters[0, 20]
  end
end
