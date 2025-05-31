class AddCompletedToGames < ActiveRecord::Migration[8.0]
  def change
    add_column :games, :completed, :boolean, default: false
  end
end
