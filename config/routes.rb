Rails.application.routes.draw do
  use_doorkeeper
  
  namespace :api, defaults: { format: 'json' } do
    resources :users,  only: [:index, :create, :show, :update, :destroy]
    resources :tasks do
      collection do
        delete 'batch_destroy'
      end
    end
    get '/me' => "credentials#me"
  end

  root to: 'pages#index'
end
