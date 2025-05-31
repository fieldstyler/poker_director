class GamesController < ApplicationController
    def new
        @active_section = :game
    end

    def show
        @game = Game.find(params[:id])
        @active_section = :game
    end

    def create
        @game = Game.create(games_params)
        @active_section = :game
        redirect_to single_game_levels_path(@game.id)
    end

    def edit
        @game = Game.find(params[:id])
        @active_section = :game
    end

    def update
        @game = Game.find(params[:id])
        levels = @game.level_count
        length = @game.round_length
        @active_section = :game
        @game.update(games_params)
        redirect_to edit_single_game_levels_path(@game.id)
    end

    def levels
        @game = Game.find(params[:id])
        @levels = @game.level_count.to_i
        @count = 1
        @length = @game.round_length
        @active_section = :game
    end

    def blinds
        @game = Game.find(params[:id])
        @count = params["count"].to_i
        @active_section = :game
    end

    def break
        @game = Game.find(params[:id])
        @count = params["count"].to_i
        @active_section = :player
    end

    def new_for_league
        @league = League.find(params[:league_id])
        @game = Game.new
        @active_section = :league
    end
      
    def create_for_league
        @league = League.find(params[:league_id])
        @game = Game.create(games_params.merge(league_id: @league.id))
        if @game.persisted?
            redirect_to league_games_levels_path(@league, @game), notice: "Game created. Now set up the levels."
        else
            render :new_for_league, status: :unprocessable_entity
        end
        @active_section = :league
    end

    def edit_for_league
        @league = League.find(params[:league_id])
        @game = Game.find(params[:id])
        @active_section = :league
    end

    def update_for_league
        @game = Game.find(params[:id])
        @league = @game.league

        new_level_count = params[:game][:level_count].to_i
        new_round_length = params[:game][:round_length].to_i

        levels_changed = @game.level_count.to_i != new_level_count
        length_changed = @game.round_length.to_i != new_round_length
        @active_section = :league
        if @game.update(games_params)
            redirect_to @league ? edit_league_game_levels_path(@league, @game) : edit_single_game_levels_path(@game)
        else
            render :edit, status: :unprocessable_entity
        end
    end
    
    def levels_for_league
        @league = League.find(params[:league_id])
        @game = Game.find(params[:id])
        @levels = @game.level_count
        @length = @game.round_length
        @count = 1
        @active_section = :league
    end

    def start_session
        @league = League.find(params[:league_id])
        last_game = @league.games.last
        # If the last game is complete, make a new one
        if last_game&.completed
          @game = @league.games.create!(
            buy_in: last_game.buy_in,
            places_paid: last_game.places_paid,
            starting_stack: last_game.starting_stack,
            round_length: last_game.round_length,
            level_count: last_game.level_count,
            knockouts: last_game.knockouts,
            completed: false
          )
          # Copy over levels from the last game
          last_game.levels.each do |level|
            @game.levels.create!(
              sb: level.sb,
              bb: level.bb,
              ante: level.ante,
              length: level.length,
              break: level.break,
              break_length: level.break_length
            )
          end
        else
          @game = last_game
        end

        # Grab the previous game's bounty winner
        previous_bounty_winner = @league.games
          .order(:created_at)
          .to_a[-2]
          &.game_players
          &.find_by(bounty: true)
        
        @league.players.each do |player|
          unless GamePlayer.exists?(game: @game, player: player)
            GamePlayer.create!(
              game: @game,
              player: player,
              points: 0,
              knockouts: 0,
              bounty: previous_bounty_winner&.player_id == player.id
            )
          end
        end

        @active_section = :league
        redirect_to league_game_blinds_path(@league.id, @game.id, count: 1, hard: true)
    end

    def play_league_level
        @league = League.find(params[:league_id])
        @game = Game.find(params[:id])
        redirect_to league_path(@league) if @game.completed? 
        @count = params[:count].to_i
        @active_section = :league
    end

    def play_league_level_break
        @league = League.find(params[:league_id])
        @game = Game.find(params[:id])
        redirect_to league_path(@league) if @game.completed? 
        @count = params[:count].to_i
        @active_section = :player
    end

    def knockout
        @game = Game.find(params[:id])
        knocker_id = params[:knocker_id]
        victim_id = params[:victim_id]
        
        if knocker_id == victim_id
            return render json: { success: false, error: "A player cannot knock themselves out." }, status: :unprocessable_entity
        end
          
        knocker = GamePlayer.find_by(game: @game, player_id: knocker_id)
        victim = GamePlayer.find_by(game: @game, player_id: victim_id)
        
        if knocker && victim
          knocker.increment!(:session_knockouts)
          victim.update(eliminated: true, eliminated_by_id: knocker.id) if victim.respond_to?(:eliminated)
          render json: {
            success: true,
            knocker_name: knocker.player.full_name,
            victim_name: victim.player.full_name,
            victim_id: victim.player_id,
            new_count: knocker.session_knockouts
          }
        else
          render json: { success: false, error: "Knocker or victim not found" }, status: :unprocessable_entity
        end
    end

    def complete_session
        game = Game.find(params[:id])
        league = game.league
        game_players = game.game_players.includes(:player)
      
        # Determine placements (last to first based on elimination or survival)
        placements = game_players.where(eliminated: true)
                         .order(:updated_at) # earliest eliminated = last place
                         .to_a

        winner = game_players.find_by(eliminated: false)
        placements << winner if winner

        winner = placements.last
        winner.update!(bounty: true)
        placements.each_with_index do |gp, index|
            placement_points = index * 3 # 0 for last, 3 for 2nd-to-last, etc.
            knockout_points = gp.session_knockouts * 3
            bounty = game_players.find_by(bounty: true)
            # Bonus for knocking out the bounty (additional 2 points)
            knocked_out_bounty = bounty.eliminated_by_id == gp.id 
            bounty_bonus = knocked_out_bounty ? 2 : 0
        
            total = placement_points + knockout_points + bounty_bonus
        
            gp.update!(session_points: total)
        
            # Add to league season totals
            league_player = LeaguePlayer.find_by(player: gp.player, league: league)
            league_player.increment!(:season_points, total)
            league_player.increment!(:season_knockouts, gp.session_knockouts)
        end
        
        game.update!(completed: true)
        redirect_to league_path(league), notice: "Session complete! Points calculated."
      end

    private

    def games_params
        params.require(:game).permit(:player_count, :buy_in, :starting_stack, :round_length, :places_paid, :knockouts, :rebuys, :level_count)
    end
end
