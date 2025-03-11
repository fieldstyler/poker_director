class CreateGame < ActiveRecord::Migration[8.0]
  def change
    create_table :games do |t|
      t.string :buy_in
      t.string :starting_stack
      t.string :round_length
      t.string :places_paid
      t.boolean :knockouts
      t.string :level_count

      t.timestamps
    end
  end
end
