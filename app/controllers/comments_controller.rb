class CommentsController < ApplicationController
  protect_from_forgery except: [:create]
  def create
    @post = Post.find_by(params[:post_id])
    @comments = Comment.new(
      content: params[:content],
      user_id: @current_user.id,
      post_id: @post.id
    )

    if @comments.save

      flash[:notice] = 'コメントを作成しました'
      redirect_to("/posts/#{params[:post_id]}")
    else
      flash[:notice] = 'コメントの作成に失敗しました'
      redirect_to("/posts/#{params[:post_id]}")
    end
  end

  def destroy
    @post = Post.find_by(params[:post_id])
    @comments = Comment.find_by(id: params[:id])
    @comments.destroy
    flash[:notice] = 'コメントを削除しました'
    redirect_to("/posts/#{params[:post_id]}")
  end
end
