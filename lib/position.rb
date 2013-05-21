class Position

  def initialize(security, market_price, market_date, *buys)
    @security = security
    @market_price = BigDecimal(market_price)
    @market_date = market_date
    @buys = buys
  end

  def quantity
    @buys.inject(BigDecimal('0')){|memo, obj| memo + obj.quantity }
  end

  def cost
    @buys.inject(BigDecimal('0')){|memo, obj| memo + obj.cost }
  end

  def market_value
    (@market_price * quantity).round(2)
  end

  def market_value_by_sum(market_price)
    @buys.inject(BigDecimal('0')){|memo, obj| memo + obj.market_value(market_price) }
  end

  def unrealized_gain_or_loss
    (market_value - cost).round(2)
  end

  def percent_gain_or_loss
    (((market_value - cost) / cost) * 100).round(2)
  end

  def average_unit_cost
    (cost / quantity).round(4)
  end

end
