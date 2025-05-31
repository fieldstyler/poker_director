class AddLeagueToGames < ActiveRecord::Migration[8.0]
  def change
    add_reference :games, :league, foreign_key: true, null: true
  end
end
