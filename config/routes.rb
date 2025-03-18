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
  get "/leagues/index" => "leagues#index"
  get "/players/index" => "players#index"
  post "/games/new/levels" => "games#create"
  get "/games/new/levels/:id" => "games#levels", as: :single_game_levels
  post "/levels/create" => "levels#create"
  get "/games/show/:id" => "games#show", as: :games_show
  get "games/start/:id" => "games#start", as: :start_single_game
  get "games/edit/:id" => "games#edit", as: :edit_game
  patch "games/update/:id" => "games#update", as: :update_game
  get "/levels/edit/:id" => "levels#edit", as: :edit_single_game_levels
  patch "games/levels/update/:id" => "levels#update", as: :levels_update
end
