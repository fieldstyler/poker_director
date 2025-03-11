class Game < ApplicationRecord
    validates_presence_of :buy_in
    validates_presence_of :starting_stack
    validates_presence_of :round_length
    validates_presence_of :places_paid
    validates :knockouts, presence: true, allow_blank: true
    validates_presence_of :level_count
end