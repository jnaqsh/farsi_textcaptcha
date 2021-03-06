#encoding: utf-8

class UserMailer < ActionMailer::Base
  default from: "do_not_reply@textcaptcha.ir"

  def send_api_key(user_id)
    @user = User.find(user_id)
    mail(:to => "#{@user.full_name} <#{@user.email}>", :subject => "API کپچای متنی")
  end

  def send_api_key_reset(user_id)
    @user = User.find(user_id)
    mail(:to => "#{@user.full_name} <#{@user.email}>", :subject => "بازنشانی کلید API کپچای متنی")
  end
end
