Rails.application.routes.draw do
  root 'application#index'
 
  devise_for :users, controllers: {
      sessions: 'users/sessions'
  }

  scope "/admin" do
    resources :users
    post '/users/savenew', to: 'users#savenew'
  end

  match '/reservation/check_out',   to: 'reservations#check_out',   via: 'get'
  match '/reservation/return',   to: 'reservations#return',   via: 'get'
  resources :reservations

  resources :cars

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
