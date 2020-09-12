Rails.application.routes.draw do
  devise_for :users

  resources :stations, only: %i[show index]
  resources :trips, only: %i[index create destroy]

  root to: 'stations#index'
end
