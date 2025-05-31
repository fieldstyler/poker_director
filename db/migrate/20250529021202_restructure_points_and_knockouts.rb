class RestructurePointsAndKnockouts < ActiveRecord::Migration[8.0]
  def change
    remove_column :players, :session_points, :integer
    remove_column :players, :season_points, :integer
    remove_column :players, :session_knockouts, :integer
    remove_column :players, :season_knockouts, :integer

    add_column :game_players, :session_points, :integer, default: 0
    add_column :game_players, :session_knockouts, :integer, default: 0
    add_column :game_players, :bounty, :boolean, default: false

    add_column :league_players, :season_points, :integer, default: 0
    add_column :league_players, :season_knockouts, :integer, default: 0
  end
end
