class Trade < ApplicationRecord
  belongs_to :position

  validates :type, inclusion: { in: %w(buy sell),
    message: "%{value} is not a valid type (buy/sell)" }
  validates :order_type, inclusion: { in: %w(limit market),
    message: "%{value} is not a valid order type (limit/market)" }
  validates :status, inclusion: { in: %w(pending filled canceled),
    message: "%{value} is not a valid status (pending/filled/canceled)" }

  def buy_to_open

  end

  def sell_to_close

  end

  def buy_to_close

  end

  def sell_to_open

  end
end
