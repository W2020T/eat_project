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
    @tag_list = Tag.all
  end

  def show
    @post = Post.find_by(id: params[:id])
    @user = @post.user
    @likes_count = Like.where(post_id: @post.id).count
    @comment = Comment.new
    @comments = @post.comments.page(params[:page]).per(7).reverse_order
    @post_tags = @post.tags
  end

  def edit
    @post = Post.find_by(id: params[:id])
    @tag_list = @post.tags.pluck(:tag_name).join(',')
  end

  def new
    if @current_user.nil?
      flash[:notice] = 'ログインが必要です'
      redirect_to('/login')
    end
    @post = Post.new
  end

  def destroy
    @post = Post.find_by(id: params[:id])

    @post.destroy
    @post.image.purge if params[:image]
    flash[:notice] = '投稿を削除しました'
    redirect_to('/posts/index')
  end

  def create
    @post = Post.new(
      content: params[:content],

      user_id: @current_user.id
    )

    tag_list = params[:post][:tag_name].split(nil)
    if image = params[:post][:image]
      @post.image.attach(image)

    end
    if @post.save
      @post.save_tag(tag_list)
      flash[:notice] = '投稿を作成しました'

      redirect_to('/posts/index')
    else
      render('posts/new')
    end
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

  def search
    @posts = if params[:content].present?
               Post.where('content LIKE ?', "%#{params[:content]}%")
             else
               Post.none
             end
  end

  def tag_search
    @tag_list = Tag.all
    @tag = Tag.find(params[:tag_id])
    @posts = @tag.posts.all
  end
end
