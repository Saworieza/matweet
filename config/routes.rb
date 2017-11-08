Rails.application.routes.draw do

  get 'messages', to: 'messages#index', as: :messages

  root to: "home#index"

  get "hashtags/:hashtag",   to: "hashtags#show",      as: :hashtag
  get "hashtags",            to: "hashtags#index",     as: :hashtags
  devise_for :users
  resources :tweets do
    resources :comments
    member do
      post :retweet
      get "like"
      get "unlike"
    end
  end

  resources :comments do
    resources :comments
  end

  resources :conversations, only: [:create] do
    member do
      post :close
    end
  # resources :messages, only: [:create]
  end

  resources :activities
  resources :users do
    member do
      get :following, :followers
    end
  end
  resources :relationships, only: [:create, :destroy]

end
