class UserMailer < ApplicationMailer
  def account_activation user
    @user = user
    mail to: user.email, subject: Settings.mail.subject
  end

  def password_reset
    mail to: Settings.mail.mailTo
  end
end
