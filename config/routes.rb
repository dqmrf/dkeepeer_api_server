Rails.application.routes.draw do
  use_doorkeeper
  
  namespace :api do
    resources :users,  only: [:index, :create, :show, :update, :destroy]
    resources :tasks,  only: [:index, :create, :show, :update, :destroy]
  end

  root to: 'pages#index'

  # resources :users, only: [:new, :create]
  # resources :sessions, only: [:new, :create]
  # delete '/logout', to: 'sessions#destroy', as: :logout

  # namespace :api do
  #   get 'user', to: 'users#show'
  #   get 'user/update', to: 'users#update'
  #   resources :tasks
  # end
end
