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
#  login_token     :string(255)
#

class Organization < ActiveRecord::Base
  attr_accessible :description, :email, :name, :password, :password_confirmation
  has_secure_password

  before_save { |organization| organization.email.downcase! }
  before_save :create_login_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, on: :create
  validates :password_confirmation, presence: true, on: :create

  validate :email_absent_in_users

private

  def email_absent_in_users
    if User.find_by_email(email)
      errors.add(:email, "is already taken")
    end
  end

  def create_login_token
    self.login_token = SecureRandom.urlsafe_base64
  end
end
