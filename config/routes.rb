Rails.application.routes.draw do
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

  root to: 'dashboard#index', constraints: RouteConstraints::UserRequiredConstraint.new
  root to: 'page#welcome', constraints: RouteConstraints::NoUserRequiredConstraint.new,
       as: :landing
end
