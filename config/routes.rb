Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)

  root "games#index"
  resources :games, only: [:index, :show] do
    collection do
      get "search", to: "games#search"
    end
  end

  get "about", to: "about#index"
  get "contact", to: "contact#index"
end
