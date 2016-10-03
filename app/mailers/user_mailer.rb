class UserMailer < ApplicationMailer
  default from: "\"David's Site\" <no-reply@example.com>"

  def welcome_email(user)
    @user = user
    mail(to: @user.email, subject: 'Welcome to My Site')
  end
end
