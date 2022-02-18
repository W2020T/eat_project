# frozen_string_literal: true

class PostsController < ApplicationController
  before_action :ensure_correct_user, { only: %i[edit update destroy] }
  before_action :authenticate_user

  def ensure_correct_user
    @post = Post.find_by(id: params[:id])
    return unless @post.user_id != @current_user.id

    flash[:notice] = '権限がありません'
    redirect_to('/posts/index')
  end

  def index
    @posts = Post.all.order(created_at: :desc)
    @posts = Post.all.page(params[:page]).per(1)
    # @comments = @post.comments.page(params[:page]).per(7).reverse_order
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
    @comment = Comment.new
    @comments = @post.comments.page(params[:page]).per(7).reverse_order
  end

  def edit
    @post = Post.find_by(id: params[:id])
  end

  def new
    if @current_user.nil?
      flash[:notice] = 'ログインが必要です'
      redirect_to('/login')
    end
    @post = Post.new
  end

  def create
    @post = Post.new(
      content: params[:content],

      user_id: @current_user.id
    )
    @post.image.attach(params[:image])
    image = params[:image] if params[:image]
    if @post.save
      flash[:notice] = '投稿を作成しました'
      redirect_to('/posts/index')
    else
      render('posts/new')
    end

    def update
      @post = Post.find_by(id: params[:id])
      @post.content = params[:content]
      if @post.save
        flash[:notice] = '投稿を編集できました！'
        redirect_to('/posts/index')
      else
        flash[:notice] = '投稿は100文字以内で入力してください'
        render('posts/edit')
      end
    end

    def destroy
      @post = Post.find_by(id: params[:id])
      @post.destroy
      flash[:notice] = '投稿を削除しました'
      redirect_to('/posts/index')
    end

    def search
      @posts = if params[:content].present?
                 Post.where('content LIKE ?', "%#{params[:content]}%")
               else
                 Post.none
               end
    end
  end
end
