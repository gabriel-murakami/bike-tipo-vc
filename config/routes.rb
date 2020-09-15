Rails.application.routes.draw do
  devise_for :users

  resources :stations, only: :index
  resources :trips, only: :index
  resource :withdraws, only: :create
  resource :devolutions, only: :create

  root to: 'stations#index'
end
