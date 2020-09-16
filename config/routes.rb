Rails.application.routes.draw do
  devise_for :users

  resource :devolutions, only: :create
  resource :damage_reports, only: :create
  resources :stations, only: :index
  resources :trips, only: :index
  resource :withdraws, only: :create

  root to: 'stations#index'
end
