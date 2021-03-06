class ReviewMailer < ApplicationMailer
  default from: "davidcnelson9491@gmail.com"

  def review_email(user, team, review)
    @user = user
    @team = team
    @review = review
    mail(to: @user.email, subject: 'You Have a New Review')
  end
end
