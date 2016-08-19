Rails.application.routes.draw do
  # Static pages (home, about)
  root 'dashboard#home'

  get 'recent' => 'pages#recent'
  get 'recent/:page' => 'pages#recent'

  get 'top' => 'pages#top'
  get 'top/:page' => 'pages#top'

  get 'random' => 'pages#random'

  # List routes (view, create, etc.)
  resources :lists, only: [:new, :show, :create, :update, :destroy] do
    resources :items, only: [:edit, :create, :update, :destroy] do
      post '/swap/:swap_id' => 'items#swap'
    end 

    resources :comments, only: [:create, :destroy]

    post '/like' => 'lists#like'
  end

  # User routes (signup, profile viewing)
  get 'signup' => 'users#new'
  get 'profile' => 'users#show'
  resources :users

  # Login routes (Login and logout)
  get 'login' => 'sessions#new'
  post 'login' => 'sessions#create'
  delete 'logout' => 'sessions#destroy'
end
