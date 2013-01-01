class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :load_number_of_approved_questions, :authorize

  private

  def load_number_of_approved_questions
    @number_of_approved_questions = Question.approved.count
  end

  def current_user
    @current_user ||= User.admins.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def authorize
    unless session[:user_id] && User.admins.find(session[:user_id])
      flash[:error] = t('controllers.application.authorize.flash.error')
      redirect_to new_session_path
    end
  end

  def bypass_captcha_or_not(object)
    object.skip_textcaptcha = current_user ? true : false
  end
end
