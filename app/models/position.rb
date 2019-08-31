class Position < ApplicationRecord
  belongs_to :instrument
  has_many :trades

  validates :status, inclusion: { in: %w(open closed),
    message: "%{value} is not a valid status (open/closed)" }
end
