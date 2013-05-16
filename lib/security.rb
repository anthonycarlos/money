require 'date'
require 'bigdecimal'

class Security
  attr_reader :symbol, :description, :market_price, :market_date
  def initialize(symbol, description, market_price, market_date)
    @symbol = symbol
    @description = description
    @market_price = BigDecimal.new(market_price)
    @market_date = market_date
  end
end


