class PasswordMailer < ApplicationMailer

  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.password_mailer.reset.subject
  #
  def reset
    @user = params[:user]

    @token = @user.signed_id(purpose: 'password_reset', expires_in: 30.minutes)
    attachments.inline["logo.png"] = File.read("#{Rails.root}/app/assets/images/Logo EduLearn.png")

    mail to: @user.email, subject:"Reinicio de contraseña EduLearn"
  end
end
