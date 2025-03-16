class CreateLevels < ActiveRecord::Migration[8.0]
  def change
    create_table :levels do |t|
      t.string :sb
      t.string :bb
      t.string :ante
      t.string :length
      t.references :game, null: false, foreign_key: true

      t.timestamps
    end
  end
end
