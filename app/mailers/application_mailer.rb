class ApplicationMailer < ActionMailer::Base
  default from: -> { mailer_from }
  layout "mailer"

  private

  def mailer_from
    profile = BusinessProfile.instance
    name  = profile.name.presence  || "Invoice App"
    email = profile.email.presence || "noreply@example.com"
    "#{name} <#{email}>"
  end
end
