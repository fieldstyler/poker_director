class GamesController < ApplicationController
    def new 
        
    end

    def show
        @game = Game.find(params[:id])
    end
    
    def create
        @game = Game.create(games_params)
        redirect_to single_game_levels_path(@game.id)
    end
    
    def edit
        @game = Game.find(params[:id])
    end
    
    def update
        @game = Game.find(params[:id])
        levels = @game.level_count
        length = @game.round_length
        if levels == params["level_count"] && length == params["round_length"]
            @game.update(games_params)
            redirect_to games_show_path(@game.id)
        else
            @game.update(games_params)
            redirect_to edit_single_game_levels_path(@game.id)
        end
    end
    
    def levels
        @game = Game.find(params[:id])
        @levels = @game.level_count.to
        @count = 1
        @length = @game.round_length
    end
    
    def start
        @game = Game.find(params[:id])
        @count = 1
    end
    
    private
    
    def games_params
        params.permit(:buy_in, :starting_stack, :round_length, :places_paid, :knockouts, :level_count)
    end
    
end