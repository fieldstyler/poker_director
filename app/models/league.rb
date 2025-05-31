class League < ApplicationRecord
    has_many :league_players, dependent: :destroy
    has_many :players, through: :league_players
    
    validates :name, presence: true
    validates :number_of_sessions, numericality: { only_integer: true, greater_than_or_equal_to: 0 }

    has_many :games, dependent: :destroy

    def completed_sessions
      games.where(completed: true).count
    end 
  end
  