class AddDefaultToGamePlayerEliminated < ActiveRecord::Migration[8.0]
  def change
    change_column_default :game_players, :eliminated, from: nil, to: false
  end
end
