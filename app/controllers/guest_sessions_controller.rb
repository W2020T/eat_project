# frozen_string_literal: true

class GuestSessionsController < ApplicationController
  def new_guest
    user = User.find_or_create_by(email: 'guest@exapmle.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
    end
    session[:user_id] = user.id
    flash[:notice] = 'ゲストユーザーとしてログインしました'
    redirect_to('/posts/index')
  end
end
