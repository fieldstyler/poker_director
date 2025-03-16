class LevelsController < ApplicationController
    def create 
        @game = Game.find(params[:id])
        create_blind_levels(params, @game)
        redirect_to games_show_path(@game.id)
    end

    private
    
    def create_blind_levels(params, game, count=1)
        until params["sb#{count}"].nil?
            Level.create(game_id: game.id, sb: params["sb#{count}"], bb: params["bb#{count}"], ante: params["ante#{count}"], length: params["length#{count}"])
            count += 1
        end
    end
end