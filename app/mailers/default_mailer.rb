class DefaultMailer < ApplicationMailer
  default from: 'rails-app@example.org'

  def welcome_message(user)
    @user = user
    mail to: @user.address, subject: 'Testing out some Mailgun goodness!'
  end

end
