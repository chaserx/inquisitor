Rails.application.routes.draw do
  if Rails.env.development?
    mount DrawErd::Engine, at: '/rails/draw/erd'
  end

  resources :user_sessions
  get 'login' => 'user_sessions#new', as: :login
  post 'logout' => 'user_sessions#destroy', as: :logout

  resources :users do
    resources :mobile_phones, except: [:index] do
      member do
        post :verify
        get  :reset
      end
    end
  end

  root to: 'users#index'
end
