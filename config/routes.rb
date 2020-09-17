Rails.application.routes.draw do
  devise_for :users

  resource :devolutions, only: :create
  resource :withdraws, only: :create

  resources :stations, only: :index
  resources :trips, only: :index

  resource :damage_reports, only: :create
  resource :billings, only: :create

  root to: 'stations#index'
end
