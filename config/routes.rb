Rails.application.routes.draw do
  root 'sessions#new'
  resources :users do
    member do
      get :activate
      patch :post_create
    end
  end

  get '/sign_up', to: 'users#new', as: :signup

  resources :sessions
  get '/login', to: 'sessions#new', as: :login
  delete '/logout', to: 'sessions#destroy', as: :logout

  resources :reset_passwords, only: %i[new create update edit]
end
