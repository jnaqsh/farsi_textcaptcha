class ApiKeyResetsController < ApplicationController
  skip_before_filter :authorize

  def new
  end

  def create
    user = User.find_by_email(params[:email])
    user.send_api_key_reset if user
    redirect_to root_url, notice: t('controllers.api_key_resets.create.flash.success')
  end
end
