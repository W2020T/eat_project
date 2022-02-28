class SessionsController < ApplicationController
  skip_before_action :check_logged_in, raise: false

  def create
    user = User.from_omniauth(request.env['omniauth.auth'])
    if user.save
      session[:user_id] = user.id
      redirect_to root_path
    else
      redirect_to new_session_path
    end
  end

  def destroy
    log_out
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
