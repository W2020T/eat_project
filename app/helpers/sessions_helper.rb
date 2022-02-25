module SessionsHelper
  def current_user
    return unless (@user_id = session[:user_id])

    @current_user ||= User.find_by(id: user_id)
  end

  def log_out
    session[:user_id] = nil
    flash[:notice] = 'ログアウトしました'
  end

  def check_logged_in
    return if current_user

    redirect_to root_path
  end
end
