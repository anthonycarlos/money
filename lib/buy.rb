require 'date'
require 'bigdecimal'
require 'security'

class Buy
  def initialize(security, quantity, acquire_date, unit_cost)
    @security = security
    @quantity = BigDecimal(quantity)
    @acquire_date = acquire_date
    @unit_cost = BigDecimal(unit_cost)
  end

  def cost
    (@quantity * @unit_cost).round(2)
  end

  def market_value(market_price)
    (@quantity * BigDecimal(market_price)).round(2)
  end

  def unrealized_gain_or_loss(market_price)
    market_value(market_price) - cost
  end

  def percent_gain_or_loss(market_price)
    (((market_value(market_price) - cost) / cost) * 100).round(2)
  end

end

