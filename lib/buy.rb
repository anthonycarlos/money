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

  def market_price
    @security.market_price
  end

  def market_value
    (@quantity * market_price).round(2)
  end

  def unrealized_gain_or_loss
    market_value - cost
  end

  def percent_gain_or_loss
    (((market_value - cost) / cost) * 100).round(2)
  end

end

#security = Security.new('YAFFX', 'Yacktman Focused Fund', '23.3900')
#b1 = Buy.new(security, '137.6650', Date.new(2011, 8, 17), '18.1600')
#puts b1.cost.to_s('F')
#puts b1.market_price.to_s('F')
#puts b1.market_value.to_s('F')
#puts b1.unrealized_gain_or_loss.to_s('F')
#puts b1.percent_gain_or_loss.to_s('F')
