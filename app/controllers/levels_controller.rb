class LevelsController < ApplicationController
    def create
        @game = Game.find(params[:id])
        create_blind_levels(params, @game)
        redirect_to games_show_path(@game.id)
    end

    def edit
        @game = Game.find(params["id"])
        @prev_levels = @game.levels.count
        @levels = @game.level_count.to_i
        @new_levels = @levels - @prev_levels
        @count = 1
        @length = @game.round_length
    end

    def update
        @game = Game.find(params[:id])
        @game.levels.delete_all
        create_blind_levels(params, @game)
        redirect_to games_show_path(@game.id)
    end

    private

    def create_blind_levels(params, game, count = 1)
        until params["sb#{count}"].nil?
            Level.create(game_id: game.id, sb: params["sb#{count}"], bb: params["bb#{count}"], ante: params["ante#{count}"], length: params["length#{count}"], break: params["break#{count}"], break_length: params["break_length#{count}"])
            count += 1
        end
    end
end
