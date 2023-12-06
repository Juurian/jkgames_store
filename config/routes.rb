Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "games#index"
  resources :games, only: [:index, :show] do
    collection do
      get "search", to: "games#search"
    end
  end

  resources :cart, only: [:create, :destroy]

  get "about", to: "about#index"
  get "contact", to: "contact#index"

  get '/storage/game_master_image/:game_id/:image_name', to: 'games#show_image', as: 'game_image'
  delete '/cart/:id', to: 'cart#destroy'


end
