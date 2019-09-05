class Trade < ApplicationRecord
  belongs_to :instrument
  belongs_to :position

  validates :order_type, inclusion: { in: %w(buy sell),
    message: "%{value} is not a valid order type (buy/sell)" }
  validates :entry_type, inclusion: { in: %w(limit market),
    message: "%{value} is not a valid entry type (limit/market)" }
  validates :status, inclusion: { in: %w(pending filled canceled),
    message: "%{value} is not a valid status (pending/filled/canceled)" }

end
