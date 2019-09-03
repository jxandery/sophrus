Fabricator(:buy_trade) do
  instrument
  position
  type { 'buy' }
  order_type { 'limit' }
  quantity { '7.0' }
  price { '100.00' }
end

Fabricator(:sell_trade) do
  instrument
  position
  type { 'sell' }
  order_type { 'limit' }
  quantity { '7.0' }
  price { '100.00' }
end
