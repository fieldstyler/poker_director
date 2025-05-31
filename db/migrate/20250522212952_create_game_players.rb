class CreateGamePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :game_players do |t|
      t.references :game, null: false, foreign_key: true
      t.references :player, null: false, foreign_key: true
      t.integer :points, default: 0
      t.integer :knockouts, default: 0

      t.timestamps
    end
  end
end
