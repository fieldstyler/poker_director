Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Defines the root path route ("/")
  # root "posts#index"

  root "home#index"

  get "/games/new" => "games#new", as: :new_single_game
  get "/games/start" => "games#start", as: :new_single_game_start
  get "/leagues/index" => "leagues#index"
  get "/players/index" => "players#index"
  post "/games/new/blinds" => "games#create"
  get "/games/new/blinds/:id" => "games#blinds", as: :single_game_blinds
end
