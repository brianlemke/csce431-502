class Loginprovider < ActiveRecord::Base
	attr_accessible :provider, :loginid
	belongs_to :user
end
