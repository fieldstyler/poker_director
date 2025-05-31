class AddPlayerCountToGame < ActiveRecord::Migration[8.0]
  def change
    add_column :games, :player_count, :integer, default: nil
  end
end
