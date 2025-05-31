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

    # == Players ==
  get    "/players",          to: "players#index",   as: :players
  get    "/players/new",      to: "players#new",     as: :new_player
  post   "/players",          to: "players#create"
  get    "/players/:id",      to: "players#show",    as: :player
  get    "/players/:id/edit", to: "players#edit",    as: :edit_player
  patch  "/players/:id",      to: "players#update"
  delete "/players/:id",      to: "players#destroy"

  # == Leagues ==
  get    "/leagues",          to: "leagues#index",   as: :leagues
  get    "/leagues/new",      to: "leagues#new",     as: :new_league
  post   "/leagues",          to: "leagues#create"
  get    "/leagues/:id",      to: "leagues#show",    as: :league
  get    "/leagues/:id/edit", to: "leagues#edit",    as: :edit_league
  patch  "/leagues/:id",      to: "leagues#update"
  put    "/leagues/:id",      to: "leagues#update"
  delete "/leagues/:id",      to: "leagues#destroy"
  patch  "/leagues/:id/update_standings", to: "leagues#update_standings", as: :update_standings_league

  # == Games ==
  get    "/games/new",              to: "games#new",          as: :new_single_game
  post   "/games/new/levels",      to: "games#create"
  get    "/games/show/:id",        to: "games#show",         as: :games_show
  get    "/games/edit/:id",        to: "games#edit",         as: :edit_game
  patch  "/games/update/:id",      to: "games#update",       as: :update_game

  # == LeagueGames ==
  get  "/leagues/:league_id/games/new", to: "games#new_for_league", as: :new_league_game
  post "/leagues/:league_id/games", to: "games#create_for_league", as: :league_games
  get  "/leagues/:league_id/games/levels/:id", to: "games#levels_for_league", as: :league_games_levels
  get "/leagues/:league_id/games/:id/edit", to: "games#edit_for_league", as: :edit_league_game
  post "/leagues/:league_id/games/levels/create", to: "levels#create_for_league", as: :league_levels_create
  patch "/leagues/:league_id/games/:id", to: "games#update_for_league", as: :update_league_game
  get "/leagues/:league_id/games/:id/edit_levels", to: "levels#edit", as: :edit_league_game_levels
  post "/leagues/:league_id/sessions/start", to: "games#start_session", as: :start_league_session

  # == Levels (within Games) ==
  get    "/games/new/levels/:id",     to: "games#levels",     as: :single_game_levels
  get    "/levels/edit/:id",          to: "levels#edit",      as: :edit_single_game_levels
  patch  "/games/levels/update/:id",  to: "levels#update",    as: :levels_update
  post   "/levels/create",            to: "levels#create"

  # == Game Flow ==
  get    "/games/start/:id/level/:count",           to: "games#blinds", as: :game_blinds
  get    "/games/start/:id/level/:count/break",     to: "games#break",  as: :game_break
  get "/leagues/:league_id/games/:id/start/level/:count", to: "games#play_league_level", as: :league_game_blinds
  get "/leagues/:league_id/games/:id/start/level/:count/break", to: "games#play_league_level_break", as: :league_game_break

  post "/games/:id/knockout", to: "games#knockout", as: :knockout_game
  post "/games/:id/complete", to: "games#complete_session", as: :complete_session_game

  # get "/games/new" => "games#new", as: :new_single_game
  # get "/leagues" => "leagues#index"
  # get "/players/new" => "players#new", as: :new_player
  # post "/players" => "players#create", as: :players
  # get "/players/:id/edit" => "players#edit", as: :edit_player
  # get "/players/:id" => "players#show", as: :player
  # patch "/players/:id" => "players#update"
  # get "/players" => "players#index"
  # delete "/players/:id" => "players#destroy"
  # post "/games/new/levels" => "games#create"
  # get "/games/new/levels/:id" => "games#levels", as: :single_game_levels
  # post "/levels/create" => "levels#create"
  # get "/games/show/:id" => "games#show", as: :games_show
  # get "games/edit/:id" => "games#edit", as: :edit_game
  # patch "games/update/:id" => "games#update", as: :update_game
  # get "/levels/edit/:id" => "levels#edit", as: :edit_single_game_levels
  # patch "games/levels/update/:id" => "levels#update", as: :levels_update
  # get "games/start/:id/level/:count" => "games#blinds", as: :game_blinds
  # get "games/start/:id/level/:count/break" => "games#break", as: :game_break

  # get     "/leagues",          to: "leagues#index",   as: :leagues
  # get     "/leagues/new",      to: "leagues#new",     as: :new_league
  # post    "/leagues",          to: "leagues#create"
  # get     "/leagues/:id",      to: "leagues#show",    as: :league
  # get     "/leagues/:id/edit", to: "leagues#edit",    as: :edit_league
  # patch   "/leagues/:id",      to: "leagues#update"
  # put     "/leagues/:id",      to: "leagues#update"
  # delete  "/leagues/:id",      to: "leagues#destroy"

end
