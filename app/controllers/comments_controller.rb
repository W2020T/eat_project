class CommentsController < ApplicationController
  protect_from_forgery except: [:create]
  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.new(comment_params)
    @comment.user_id = current_user.id
    if @comment.save

      flash[:notice] = 'コメントを作成しました'
      redirect_to("/posts/#{params[:post_id]}")
    else
      flash[:notice] = 'コメントの作成に失敗しました'
      redirect_to("/posts/#{params[:post_id]}")
    end
  end

  def destroy
    @comment = Comment.find_by(params[:post_id])
    if @comment.destroy
      flash[:notice] = 'コメントを削除しました'
      redirect_to("/posts/#{params[:post_id]}")
    else
      flash[:notice] = 'コメントの削除に失敗しました'
      redirect_to("/posts/#{params[:post_id]}")
    end
  end

  private

  def comment_params
    params.permit(:content, :post)
  end
end
