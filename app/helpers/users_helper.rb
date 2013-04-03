module UsersHelper

	def is_user?
		current_account.is_a? User
	end
end
