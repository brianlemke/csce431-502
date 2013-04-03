# == Schema Information
#
# Table name: subscriptions
#
#  id              :integer          not null, primary key
#  user_id         :integer
#  organization_id :integer
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Subscription < ActiveRecord::Base
  attr_accessible :organization_id, :user_id
  belongs_to :organization
  belongs_to :user
end
