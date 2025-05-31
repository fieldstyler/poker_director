class Game < ApplicationRecord
    belongs_to :league, optional: true
    has_many :game_players, dependent: :destroy
    has_many :players, through: :game_players

    validates_presence_of :buy_in, :starting_stack, :round_length, :places_paid
    validates :knockouts, presence: true, allow_blank: true
    validates :rebuys, presence: true, allow_blank: true
    has_many :levels, dependent: :destroy

    def buy_in_with_dollar
        "$#{self.buy_in}"
    end
end
