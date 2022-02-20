# frozen_string_literal: true

Rails.application.routes.draw do
  post 'users/:id/update' => 'users#update'
  get 'users/:id/edit' => 'users#edit'
  post 'users/create' => 'users#create'
  get 'signup' => 'users#new'
  get 'users/index' => 'users#index'
  get 'users/search' => 'users#search'
  resources :users do
    get :search, on: :collection
  end

  get 'logout' => 'users#logout'

  # post 'login' => 'users#login'
  get 'login' => 'users#login_form'
  get 'users/:id' => 'users#show'
  get 'users/:id/likes' => 'users#likes'
  get 'users/:id/destroy' => 'users#destroy'
  get 'posts/index' => 'posts#index'
  get 'posts/search' => 'posts#search'
  resources :posts do
    get :search, on: :collection
  end
  post 'posts/:id/update' => 'posts#update'
  get 'posts/:id/destroy' => 'posts#destroy'
  resources :users, only: %i[index show]
  resources :posts, only: %i[index show create] do
  end
  get 'posts/new' => 'posts#new'

  get 'posts/:id' => 'posts#show'
  post 'posts/create' => 'posts#create'

  get 'posts/:id/edit' => 'posts#edit'

  get '/' => 'home#top'
  get 'likes/:post_id/create' => 'likes#create'
  get 'likes/:post_id/destroy' => 'likes#destroy'
  resources :users, only: %i[index show edit update] do
    resource :relationships, only: %i[create destroy] do
    end
  end
  post 'comments/create' => 'comments#create'
  resources :posts do
    resources :comments, only: %i[create destroy]
  end
  get 'comments/:id/destroy' => 'comments#destroy'
  get 'relationships/:user_id/create' => 'relationships#create'
  get 'relationships/:user_id/destroy' => 'relationships#destroy'
  get 'relationships/:user_id/followed' => 'relationships#followers'
  get 'relationships/:user_id/followings' => 'relationships#followings'
  get 'users/:id/likes' => 'users#likes'
  get '/guest_session' => 'guest_sessions#new_guest'
  get 'auth/:provider/callback' => 'sessions#create'
  get 'log_out' => 'sessions#destroy', as: 'log_out'
  resources :sessions, only: %i[create destroy]
  get 'auth/failure' => redirect('/')
end
