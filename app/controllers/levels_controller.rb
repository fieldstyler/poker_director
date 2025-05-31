class LevelsController < ApplicationController
    def create
        @active_section = :game
        @game = Game.find(params[:id])
        create_blind_levels(params, @game)
        redirect_to games_show_path(@game.id)
    end

    def edit
        @game = Game.find(params["id"])
        @game.league_id.nil? ? @active_section = :game : @active_section = :league
        @prev_levels = @game.levels.count
        @levels = @game.level_count.to_i
        @new_levels = @levels - @prev_levels
        @count = 1
        @length = @game.round_length
    end

    def update
        @active_section = :game
        @game = Game.find(params[:id])
        @game.levels.delete_all
        create_blind_levels(params, @game)
        @game.levels.reload
        
        if params[:league_id].present?
          redirect_to league_path(params[:league_id]), notice: "League game levels updated."
        else
          redirect_to games_show_path(@game), notice: "Game levels updated."
        end
      end
      

    def create_for_league
        @active_section = :league
        @game = Game.find(params[:id])
        @league = @game.league
      
        create_blind_levels(params, @game)
        @league.players.each do |player|
          GamePlayer.create(player: player, game: @game, points: 0, knockouts: 0)
        end
      
        redirect_to league_path(@league), notice: "Game levels saved and players added."
      end
      
  
    private

    def create_blind_levels(params, game, count = 1)
        until params["sb#{count}"].nil?
            Level.create(game_id: game.id, sb: params["sb#{count}"], bb: params["bb#{count}"], ante: params["ante#{count}"], length: params["length#{count}"], break: params["break#{count}"], break_length: params["break_length#{count}"])
            count += 1
        end
    end
end
