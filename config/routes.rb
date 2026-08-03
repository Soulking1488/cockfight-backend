Rails.application.routes.draw do
  root "match_cards#index"

  # Authentication Routes
  get    "/signup", to: "registrations#new"
  post   "/signup", to: "registrations#create"
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  # Core Resources
  resources :users
  resources :chickens
  resources :match_cards
  resources :bets
  resources :match_results

  namespace :admin do
    get '/', to: 'dashboard#index', as: :dashboard

    resources :match_cards do
      # Nested resource for declaring match result & triggering payouts
      resources :match_results, only: [:new, :create]
    end
end

