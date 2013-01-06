#encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: "do_not_reply@textcaptcha.ir"

  def send_api_key(user_id)
    @user = User.find(user_id)
    mail(:to => @user.email, :subject => "api کپچای متنی")
  end
end
