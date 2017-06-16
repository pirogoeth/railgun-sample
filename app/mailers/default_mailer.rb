class DefaultMailer < ApplicationMailer
  default from: 'rails-app@example.org'

  def welcome_message(user)
    @user = user
    mail to: @user.address, subject: 'Testing out some Mailgun goodness!'
  end

  def railgun_info(user)
    @user = user

    attachments['railgun_info.pdf'] = {
      :content => File.read('app/assets/attach/railgun-testing.pdf'),
      :mime_type => 'application/pdf',
    }

    mail to: @user.address, subject: 'Railgun Information'
  end

  def text_only(user)
    @user = user
    mail to: @user.address, subject: 'Testing out some text-only goodness!'
  end

end
