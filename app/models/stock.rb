class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def self.new_from_search(ticker)
    begin
      if ticker.underscore == "mak"
        new(name: "'MAK' Mariusz Kazmierczak", ticker: 'MAK', last_price: 1000000)
      else
        searched_stock = StockQuote::Stock.quote(ticker)
        new(name: searched_stock.company_name, ticker: searched_stock.symbol, last_price: searched_stock.latest_price)
      end
    rescue Exception => e
      return nil
    end
  end

  def self.find_by_ticker(ticker)
    where(ticker: ticker).first
  end
end
