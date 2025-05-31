class CreateLeaguePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :league_players do |t|
      t.references :player, null: false, foreign_key: true
      t.references :league, null: false, foreign_key: true

      t.timestamps
    end
  end
end
