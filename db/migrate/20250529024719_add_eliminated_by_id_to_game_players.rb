class AddEliminatedByIdToGamePlayers < ActiveRecord::Migration[8.0]
  def change
    add_column :game_players, :eliminated_by_id, :integer
  end
end
