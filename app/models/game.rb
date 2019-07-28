class Game < ApplicationRecord
  has_many :cells
  has_many :teams
  has_many :team_assignments, through: :teams
  has_many :users, through: :team_assignments
  has_many :messages
  validates :codename, presence: true
end
