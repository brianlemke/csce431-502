# == Schema Information
#
# Table name: organizations
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  name            :string(255)
#  description     :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#

class Organization < ActiveRecord::Base
  attr_accessible :description, :email, :name, :password, :password_confirmation
  has_secure_password

  before_save { |organization| organization.email.downcase! }

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create
end
