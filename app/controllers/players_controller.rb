class PlayersController < ApplicationController
    before_action :set_player, only: [:edit, :update, :destroy]
    before_action :set_active_section
  
    def index
      @players = if params[:query].present?
        Player.includes(:leagues)
              .where("first_name LIKE :q OR last_name LIKE :q OR substr(email, 1, instr(email, '@') - 1) LIKE :q", q: "%#{params[:query]}%")
              .sort_by(&:full_name)
      else
        Player.includes(:leagues).all.sort_by(&:full_name)
      end
    end
  
    def new
      @player = Player.new
    end

    def show 
        redirect_to players_path 
    end 
  
    def create
      @player = Player.new(player_params)
      if @player.save
        redirect_to players_path, notice: "Player was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end
  
    def edit
    end
  
    def update
      if @player.update(player_params)
        redirect_to players_path, notice: "Player was successfully updated."
      else
        render :edit, status: :unprocessable_entity
      end
    end
  
    def destroy
      @player.destroy
      redirect_to players_path, notice: "Player was successfully deleted."
    end
  
    private

    def set_active_section
      @active_section = :player
    end 
  
    def set_player
      @player = Player.find(params[:id])
    end
  
    def player_params
      params.require(:player).permit(
        :first_name,
        :last_name,
        :email,
        league_ids: []
      )
    end
    
  end
  