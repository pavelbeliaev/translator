Rails.application.routes.draw do
  root 'home#index'
  post '/', to: 'home#index'

  get '/account', to: 'account#index'
  put '/account', to: 'account#update'

  devise_for :users, controllers: { registrations: 'users/registrations' }
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
