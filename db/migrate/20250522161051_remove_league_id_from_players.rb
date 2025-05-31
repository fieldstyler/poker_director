class RemoveLeagueIdFromPlayers < ActiveRecord::Migration[8.0]
  def change
    remove_reference :players, :league, null: false, foreign_key: true
  end
end
