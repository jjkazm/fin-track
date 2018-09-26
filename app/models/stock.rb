class Stock < ApplicationRecord

  def self.new_from_search(ticker)
    begin
      if ticker.underscore == "mak"
        new(name: "'MAK' Mariusz Kazmierczak", ticker: 'MAK', last_price: 1000000)
      else
        searched_stock = StockQuote::Stock.quote(ticker)
        new(name: searched_stock.company_name, ticker: searched_stock.symbol, last_price: searched_stock.latest_price)
      end
    rescue Exception => e
      return
    end
  end
end
