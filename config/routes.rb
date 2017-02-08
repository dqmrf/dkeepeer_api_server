Rails.application.routes.draw do
  use_doorkeeper
  
  namespace :api, defaults: { format: 'json' } do
    resources :users,  only: [:index, :create, :show, :update, :destroy]
    resources :tasks,  only: [:index, :create, :show, :update, :destroy]
    get '/me' => "credentials#me"
  end

  root to: 'pages#index'
end
