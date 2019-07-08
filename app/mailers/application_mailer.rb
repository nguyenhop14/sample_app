class ApplicationMailer < ActionMailer::Base
  default from: Settings.mail.mailDefault
  layout "mailer"
end
