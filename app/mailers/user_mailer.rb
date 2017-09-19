class UserMailer < ApplicationMailer
  def email_after_sign_up(user)
    @user = user
    mail(to: @user.email, subject: 'Merci pour votre inscription!')
  end
end
