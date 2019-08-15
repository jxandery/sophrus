class Instrument < ApplicationRecord
  validates :symbol, uniqueness: true

end
