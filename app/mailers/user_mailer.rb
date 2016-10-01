class UserMailer < ApplicationMailer
  default from: 'davidcnelson9491@gmail.com'

  def welcome_email(user)
    @user = user
    # @url  = 'http://example.com/login'
    mail(to: @user.email, subject: 'Welcome to My Site')
  end
end
