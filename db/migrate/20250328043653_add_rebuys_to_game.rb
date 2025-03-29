class AddRebuysToGame < ActiveRecord::Migration[8.0]
  def change
    add_column :games, :rebuys, :boolean
  end
end
