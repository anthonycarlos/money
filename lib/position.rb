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

end
