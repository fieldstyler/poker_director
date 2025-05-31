class CreatePlayers < ActiveRecord::Migration[8.0]
  def change
    create_table :players do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.integer :session_knockouts
      t.integer :season_knockouts
      t.integer :session_points
      t.integer :season_points
      t.references :league, null: false, foreign_key: true

      t.timestamps
    end
  end
end
