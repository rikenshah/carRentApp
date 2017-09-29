Rails.application.routes.draw do
  match '/users',   to: 'users#show',   via: 'post'
  match '/reservation/check_out',   to: 'reservations#check_out',   via: 'post'
  match '/reservation/return',   to: 'reservations#return',   via: 'post'
  match '/users',   to: 'users#show',   via: 'get'

  resources :reservations
  resources :cars
  root 'application#index'
  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
