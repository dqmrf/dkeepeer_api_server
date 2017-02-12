class ApplicationMailer < ActionMailer::Base
  default from: 'mpel9797@gmail.com'
  layout 'mailer'

  def registration_confirmation(user)
    @user = user
    mail(:to => "#{user.first_name} <#{user.email}>", :subject => "Registration Confirmation")
  end
end
