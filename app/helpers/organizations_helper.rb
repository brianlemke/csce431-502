module OrganizationsHelper

	def is_organization?
		current_account.is_a? Organization
	end
end
