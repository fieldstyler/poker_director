class Level < ApplicationRecord
    validates_presence_of :sb, :bb, :ante, :length
    belongs_to :game

    def add_commas_to_small_blind(comma = 4, multiplier = 1)
        stack = 5
        length = stack.length
        length%3 == 0 ? count = (length / 3) - 1 : count = length / 3
        count.times do
            stack.insert("-#{comma*multiplier}".to_i, ",")
            multiplier += 1
        end
        stack
    end

    def add_commas_to_big_blind(comma = 4, multiplier = 1)
        stack = 5
        length = stack.length
        length%3 == 0 ? count = (length / 3) - 1 : count = length / 3
        count.times do
            stack.insert("-#{comma*multiplier}".to_i, ",")
            multiplier += 1
        end
        stack
    end
end
