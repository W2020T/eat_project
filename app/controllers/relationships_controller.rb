# frozen_string_literal: true

class RelationshipsController < ApplicationController
  before_action :authenticate_user
  def create
    following = @current_user.follow(params[:user_id])
    @user = User.find_by(params[:relationship][:user_id])
    if following.save
      user.create_notification_follow!(current_user)
      flash[:notice] = 'ユーザーをフォローしました'
    else
      'ユーザーのフォローに失敗しました'
    end
    redirect_to("/users/#{params[:user_id]}")
  end

  def destroy
    following = @current_user.unfollow(params[:user_id])
    flash[:notice] = if following.destroy
                       'ユーザーのフォローを解除しました'
                     else
                       'ユーザーのフォロー解除に失敗しました'
                     end
    redirect_to("/users/#{params[:user_id]}")
  end

  def followings
    user = User.find(params[:user_id])
    @users = user.followings
  end

  def followers
    user = User.find(params[:user_id])
    @users = user.followers
  end
end
