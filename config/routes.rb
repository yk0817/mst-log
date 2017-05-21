Rails.application.routes.draw do

  devise_for :users, :controllers => {
  :sessions      => "devise_sessions"
}
  resources :users do
    member do
      post 'instance', as: :instance #path instance_user
      post 'edit_prof', as: :edit_prof
    end
  end
  get '/' => 'users#home',via: [:get],as: :home
  get '/auth/:provider/callback' => 'sessions#create',via: [:get,:post], as: :login
  get '/logout' => 'sessions#destroy', as: :logout
end

