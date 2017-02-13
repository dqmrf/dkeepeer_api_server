Rails.application.routes.draw do
  use_doorkeeper
  
  namespace :api, defaults: { format: 'json' } do
    # Users
    resources :users,  only: [:index, :create, :show, :update, :destroy] do
      member do
        get :confirm_email
      end
    end
    # Tasks
    resources :tasks do
      collection do
        delete 'batch_destroy'
      end
    end
  end

  root to: 'doorkeeper/applications#index'
end
