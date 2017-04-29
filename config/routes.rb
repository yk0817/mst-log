Rails.application.routes.draw do

resources :users,contraints: {id: /\d+/}

end

