class SessionsController < ApplicationController
  skip_before_action :check_logged_in, raise: false

  def create
    session[:user_id] = @user.id if (@user = User.find_or_create_from_auth_hash(request.env['omniauth.auth']))
    redirect_to('/posts/index')
  end

  def destroy
    log_out
    redirect_to('/login')
  end
end
