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
    current_user.comments.find(params[:id]).destroy!
    flash[:notice] = 'コメントを削除しました'
    redirect_to("/posts/#{params[:post_id]}")
  end

  def edit
    @comment = Comment.find(params[:id])
  end

  def update
    @comment = current_user.comments.find_by(params[:id])
    @comment.content = params[:content]
    if @comment.save
      flash[:notice] = 'コメントを編集できました！'
      redirect_to("/posts/#{params[:post_id]}")
    else
      flash[:notice] = 'コメントの編集に失敗しました'
      redirect_to("/posts/#{params[:post_id]}")
    end
  end

  private

  def comment_params
    params.permit(:content, :post)
  end
end
