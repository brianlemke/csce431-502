class RegistrationMailer < ActionMailer::Base
  default from: "tamubulletin@gmail.com"

  def verified(organization)
    @organization = organization
    mail(to: @organization.email,
         subject: "Your account has been verified")
  end

  def notify_subscriptions(poster)
    @poster = poster
    @organization = poster.organization
    poster.organization.subscriptions.each do |subscription|
      @user = subscription.user
      mail(to: subscription.user.email,
           subject: "New poster from #{subscription.organization.name}").deliver
    end
  end
end
