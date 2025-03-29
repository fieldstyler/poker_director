class AddBreakInfoToLevel < ActiveRecord::Migration[8.0]
  def change
    add_column :levels, :break, :boolean
    add_column :levels, :break_length, :string
  end
end
