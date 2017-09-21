Rails.application.routes.draw do
  match '/users',   to: 'users#index',   via: 'get'

  resources :reservations
  resources :cars
  root 'application#index'
  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
