class LeaguesController < ApplicationController
    before_action :set_league, only: [:show, :edit, :update, :destroy]
    before_action :set_active_section
  
    def index
      @leagues = League.includes(:players).all
    end
  
    def show
      @league = League.find(params[:id])
      @game = @league.games.last
      @games = @league.games.order(:created_at)
    end
    
  
    def new
      @league = League.new
    end
  
    def create
      @league = League.new(league_params)
      if @league.save
        redirect_to new_league_game_path(@league), notice: "League was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
    end
  
    def update
      if @league.update(league_params)
        redirect_to league_path(@league), notice: "League was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @league.destroy
      redirect_to leagues_path, notice: "League was successfully deleted."
    end

    def update_standings
      league = League.find(params[:id])

      points = params[:points] || {}
      knockouts = params[:knockouts] || {}
      
      points.each do |lp_id, value|
        lp = LeaguePlayer.find(lp_id)
        lp.update(season_points: value)
      end

      knockouts.each do |lp_id, value|
        lp = LeaguePlayer.find(lp_id)
        lp.update(season_knockouts: value)
      end

      redirect_to league_path(league), notice: "Standings updated!"
    end
  
    private

    def set_active_section
      @active_section = :league
    end 
  
    def set_league
      @league = League.find(params[:id])
    end
  
    def league_params
        params.require(:league).permit(
          :name,
          :number_of_sessions,
          player_ids: []
        )
    end
      
  end
  