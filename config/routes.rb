Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  resources :stations, only: %i[show index]
  resources :trips, only: %i[index create destroy]

  root to: 'stations#index'
end
