class LeaguePlayer < ApplicationRecord
  belongs_to :player
  belongs_to :league

  def full_name
    "#{player.first_name} #{player.last_name}"
  end 
end
