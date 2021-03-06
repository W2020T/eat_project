# frozen_string_literal: true

class UsersController < ApplicationController
  before_action :authenticate_user, { only: %i[index show edit update search] }
  before_action :forbid_login_user, { only: %i[new create login_form login] }
  before_action :ensure_correct_user, { only: %i[edit update] }

  def ensure_correct_user
    return unless @current_user.id != params[:id].to_i

    flash[:notice] = '権限がありません'
    redirect_to('/posts/index')
  end

  def index
    @users = User.all
    @users = User.all.page(params[:page]).per(1)
  end

  def edit
    @user = User.find_by(id: params[:id])
  end

  def login_form; end

  def new
    @user = User.new
  end

  def show
    @user = User.find_by(id: params[:id])
    @currentUserEntry = Entry.where(user_id: current_user.id)
    @userEntry = Entry.where(user_id: @user.id)
    if @user.id == current_user.id
    else
      @currentUserEntry.each do |cu|
        @userEntry.each do |u|
          if cu.room_id == u.room_id
            @isRoom = true
            @roomId = cu.room_id
          end
        end
      end
      if @isRoom
      else
        @room = Room.new
        @entry = Entry.new
      end
    end
  end

  def update
    @user = User.find_by(id: params[:id])
    @user.name = params[:name]
    @user.email = params[:email]
    if params[:image]
      @user.image_name = "#{@user.id}.jpg"
      image = params[:image]
      File.binwrite("public/user_images/#{@user.image_name}", image.read)
    end

    if @user.save
      flash[:notice] = 'ユーザー情報を編集しました'
      redirect_to("/users/#{@user.id}")
    else
      render('users/edit')
    end
  end

  def login
    @user = User.find_by(email: params[:email])
    if @user&.authenticate(params[:password])
      session[:user_id] = @user.id
      flash[:notice] = 'ログインしました'
      redirect_to('/posts/index')
    else
      @error_message = 'メールアドレスまたはパスワードが間違っています'
      @email = params[:email]
      @password = params[:password]
      render('users/login_form')
    end
  end

  def logout
    session[:user_id] = nil
    flash[:notice] = 'ログアウトしました'
    redirect_to('/login')
  end

  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      image_name: 'default_user.jpg',
      password: params[:password]
    )
    @user.transaction do
      @user.save!
    end
    session[:user_id] = @user.id
    flash[:notice] = 'ユーザー登録が完了しました'
    redirect_to("/users/#{@user.id}")
  rescue StandardError => e
    flash[:notice] = 'ユーザー登録に失敗しました'
    render('users/new')
  end

  def destroy
    @user = User.find_by(params[:id])
    @user.destroy
    flash[:notice] = 'ユーザーを削除しました。'
    redirect_to('/login')
  end

  def login_form; end

  def likes
    @user = User.find_by(id: params[:id])
    @likes = Like.where(user_id: @user.id)
  end

  def search
    @users = if params[:name].present?
               User.where('name LIKE ?', "%#{params[:name]}%")
             else
               User.none
             end
  end
end
