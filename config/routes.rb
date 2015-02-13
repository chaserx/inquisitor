Rails.application.routes.draw do
  resources :user_sessions
  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout

  resources :users

  resources :cell_phones, except: [:index] do
    member do
      post :verify
      get  :reset
    end
  end

  root to: 'users#index'
end
