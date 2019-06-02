class Word < ApplicationRecord
  has_many :cells
  validates :word, presence: true
end
