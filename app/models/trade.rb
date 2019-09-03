class Trade < ApplicationRecord
  belongs_to :position

  validates :type, inclusion: { in: %w(buy sell),
    message: "%{value} is not a valid type (buy/sell)" }
  validates :order_type, inclusion: { in: %w(limit market),
    message: "%{value} is not a valid order type (limit/market)" }
  validates :status, inclusion: { in: %w(pending filled canceled),
    message: "%{value} is not a valid status (pending/filled/canceled)" }

  attr_reader :instrument, :position, :type, :order_type, :quantity, :price

end
