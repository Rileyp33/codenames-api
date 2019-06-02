class Cell < ApplicationRecord
  belongs_to :game
  belongs_to :word

  COLORS = ["red-agent", "blue-agent", "civilian", "assassin"]
  validates :color, presence: true, inclusion: COLORS
  validates :position, presence: true
  STATUSES = ["up", "down"]
  validates :flipped_status, presence: true, inclusion: STATUSES
end
