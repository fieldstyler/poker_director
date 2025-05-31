class GamePlayer < ApplicationRecord
  belongs_to :game
  belongs_to :player

  belongs_to :eliminated_by, class_name: "GamePlayer", optional: true
  has_one :eliminated_by_player, through: :eliminated_by, source: :player
end
