module KrakenClient
  class BuyToOpen

    def self.call(order, position)
      client.add_order(pair: 'XBTUSD', type: 'buy', ordertype: 'limit',
    #     volume: 1.25, price: 5000)
      Kraken::Client.add_order(opts)


      # where should the 1) create trade, 2) create/add to kraken order 3) create position, 4)
      # should a position also have a strategy? I think yes.
      # when the ticker results come back, it should check the differenthe algorithms. If the algos give a signal that should kick everything off. But should that live in the job? I think it has to.

      # create a Trade
      # have an open struct when this class is being called, it can be used by
      # other trade actions as well.
    end
  end
end
