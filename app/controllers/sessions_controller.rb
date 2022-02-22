class SessionsController < ApplicationController
  skip_before_action :check_logged_in, raise: false

  def create
    log_in user if (@user = User.find_or_create_from_auth_hash(auth_hash))
    redirect_to('/posts/index')
  end

  def destroy
    log_out
    redirect_to('/login')
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end
end
