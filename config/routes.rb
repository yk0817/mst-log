Rails.application.routes.draw do

  resources :users do
    member do
      post 'instance', as: :instance #path instance_user
    end
  end
  get '/' => 'users#home',via: [:get],as: :home
  get '/auth/:provider/callback' => 'sessions#create',via: [:get,:post], as: :login
  get '/logout' => 'sessions#destroy', as: :logout
end

