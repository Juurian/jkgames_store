Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  devise_for :users

  ## All Games Index
  root "games#index"
  resources :games, only: [:index, :show] do
    collection do
      get "search", to: "games#search"
    end
  end

  # PS4 Index
  get '/ps4', to: 'ps4#index'
  get '/ps4/search', to: 'ps4#search', as: 'search_ps4'

  # PS5 Index
  get '/ps5', to: 'ps5#index'
  get '/ps5/search', to: 'ps5#search', as: 'search_ps5'

  resources :cart, only: [:create, :destroy]

  ## About Page Index
  get "about", to: "about#index"

  ## Contact Us Index
  get "contact", to: "contact#index"

  # Cart Index
  delete '/cart/:id', to: 'cart#destroy'
  get '/cart', to: 'cart#show', as: 'cart_show'

  # Others
  get 'restricted', to: 'restricted#index', as: :restricted
  get '/storage/game_master_image/:game_id/:image_name', to: 'games#show_image', as: 'game_image'

end
