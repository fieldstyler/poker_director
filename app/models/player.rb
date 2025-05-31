class Player < ApplicationRecord
  has_many :league_players, dependent: :destroy
  has_many :leagues, through: :league_players
  has_many :game_players
  has_many :games, through: :game_players

  validates :first_name, :last_name, presence: true
  validates :email, presence: true, uniqueness: true

  def full_name
    "#{first_name} #{last_name}"
  end 
end
