class Game < ApplicationRecord
    validates_presence_of :buy_in, :starting_stack, :round_length, :places_paid
    validates :knockouts, presence: true, allow_blank: true
    has_many :levels, dependent: :destroy

    def add_commas_to_stack(comma=4, multiplier=1)
        stack = self.starting_stack
        length = stack.length 
        length%3 == 0 ? count = (length / 3) - 1 : count = length / 3
        count.times do 
            stack.insert("-#{comma*multiplier}".to_i, ",")
            multiplier += 1
        end 
        stack
    end

    def buy_in_with_dollar
        "$#{self.buy_in}"
    end
end