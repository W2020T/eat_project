# frozen_string_literal: true

class ApplicationController < ActionController::Base
  include SessionsHelper

  before_action :set_current_user

  def guest_user
    current_user == User.find_by(email: 'test@example.com')
  end

  def set_current_user
    @current_user = User.find_by(id: session[:user_id])
  end

  def authenticate_user
    return unless @current_user.nil?

    flash[:notice] = 'ログインが必要です'
    redirect_to('/login')
  end

  def forbid_login_user
    return unless @current_user

    flash[:notice] = 'すでにログインしています'
    redirect_to('/posts/index')
  end
end
