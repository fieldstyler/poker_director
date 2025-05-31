class AddDefaultValuesToPlayerStats < ActiveRecord::Migration[8.0]
  def change
    change_column_default :players, :session_knockouts, from: nil, to: 0
    change_column_default :players, :season_knockouts, from: nil, to: 0
    change_column_default :players, :session_points, from: nil, to: 0
    change_column_default :players, :season_points, from: nil, to: 0
  end
end
