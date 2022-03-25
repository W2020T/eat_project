class CommentsController < ApplicationController
  protect_from_forgery except: [:create]
  def create
    post = Post.find(params[:post_id])
    @comment = post.comments.new(comment_params)
    @comment.user_id = current_user.id
    flash[:notice] = if @comment.save
                       'コメントを作成しました'
                     else
                       'コメントの作成に失敗しました'
                     end
    redirect_to("/posts/#{params[:post_id]}")
  end

  def destroy
    current_user.comments.find(params[:id]).destroy!
    flash[:notice] = 'コメントを削除しました'
    redirect_to("/posts/#{params[:post_id]}")
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = current_user.comments.find(params[:id])
    @comment.content = params[:content]
    flash[:notice] = if @comment.save
                       'コメントを編集できました！'
                     else
                       'コメントの編集に失敗しました'
                     end
    redirect_to("/posts/#{params[:post_id]}")
  end

  private

  def comment_params
    params.permit(:content, :post)
  end
end
