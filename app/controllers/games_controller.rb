class GamesController < ApplicationController
    def new 
        
    end

    def create
        @game = Game.create(games_params)
        redirect_to single_game_blinds_path(@game.id)
    end
    
    def blinds
        @game = Game.find(params[:id])
    end

    private

    def games_params
        params.permit(:buy_in, :starting_stack, :round_length, :places_paid, :knockouts, :level_count)
    end
end