# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  email           :string(255)
#  password_digest :string(255)
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#  login_token     :string(255)
#  name            :string(255)
#  admin           :boolean          default(FALSE)
#  picture         :string(255)
#  facebookid      :string(255)
#

class User < ActiveRecord::Base
  attr_accessible :name, :email, :password, :password_confirmation, :picture, :facebookid, :password_digest
  mount_uploader :picture, ProfilePictureUploader
  has_secure_password

  before_save { |user| user.email = user.email.downcase }
  before_save :create_login_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :password, presence: true, :if => :facebookid_is_nil
  validates :password_confirmation, presence: true, on: :create, :if => :facebookid_is_nil

  validate :email_absent_in_organizations

private

  def email_absent_in_organizations
    if Organization.find_by_email(email)
      errors.add(:email, "is already taken")
    end
  end

  def create_login_token
    self.login_token = SecureRandom.urlsafe_base64
  end

  def facebookid_is_nil
    self.facebookid.blank?
  end
end
