# frozen_string_literal: true

class LikesController < ApplicationController
  def create
    @like = Like.new(
      user_id: @current_user.id,
      post_id: params[:post_id]
    )

    @like.save
    post = Post.find(params[:post_id])
    post.create_notification_like!(current_user)
    redirect_to("/posts/#{params[:post_id]}")
  end

  def destroy
    @like = Like.find_by(
      user_id: @current_user.id,
      post_id: params[:post_id]
    )
    @like.destroy
    redirect_to("/posts/#{params[:post_id]}")
  end
end
