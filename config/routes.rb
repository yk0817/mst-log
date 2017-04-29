Rails.application.routes.draw do

  resources :users,contraints: {id: /\d+/}
  get '/auth/:provider/callback' => 'sessions#create',via: [:get,:post]
  get '/logout' => 'sessions#destroy', as: :logout

end

