class UserMailer < ApplicationMailer

  def activation_needed_email(user)
    @user = user
    mail(to: user.email, subject: 'Vibly account activation')
  end

  def activation_success_email(user)
    @user = user
    mail(to: user.email, subject: 'Your vibly account is successfuly actived')
  end

  def reset_password_email(user)
    @user = user
    @url  = edit_reset_password_url(@user.reset_password_token)
    mail(to: user.email,
         subject: "Your password has been reset")
     end
end
