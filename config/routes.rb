Rails.application.routes.draw do
  resources :cell_phones, except: [:index] do
    member do
      post :verify
      get  :reset
    end
  end
end
