Rails.application.routes.draw do
  resources :user_sessions
  get 'login' => 'user_sessions#new', as: :login
  get 'logout' => 'user_sessions#destroy', as: :logout

  post 'sms/receive', to: 'sms#receive'
  get 'help', to: 'page#help', as: :help

  resources :users do
    resources :questions do
      resources :answers, except: [:new, :edit, :update, :create]
    end
    resources :mobile_phones, except: [:index] do
      member do
        post :verify
        get  :reset
      end
    end
  end

  root to: 'dashboard#index', constraints: RouteConstraints::UserRequiredConstraint.new,
       as: :dashboard
  root to: 'page#welcome', constraints: RouteConstraints::NoUserRequiredConstraint.new,
       as: :landing
end
