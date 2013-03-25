class RegistrationMailer < ActionMailer::Base
  default from: "tamubulletin@gmail.com"

  def verified(organization)
    @organization = organization
    mail(to: @organization.email,
         subject: "Your account has been verified")
  end
end
