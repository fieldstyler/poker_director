class Level < ApplicationRecord
    validates_presence_of :sb, :bb, :ante, :length
    belongs_to :game
end
