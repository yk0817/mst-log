Rails.application.routes.draw do

  resources :users
  get '/auth/:provider/callback' => 'sessions#create',via: [:get,:post], as: :login
  get '/logout' => 'sessions#destroy', as: :logout

end

