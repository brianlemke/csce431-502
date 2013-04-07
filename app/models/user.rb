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
  has_many :loginprovider

  before_save { |user| user.email = user.email.downcase }
  before_save :create_login_token

  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
            uniqueness: { case_sensitive: false }
  validates :password, presence: true, :if => :external_login_not_provided
  validates :password_confirmation, presence: true, on: :create, :if => :external_login_not_provided

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

  def external_login_not_provided
    self.password_digest != "external-authorized account"
  end
end