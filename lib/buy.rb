require 'date'
require 'bigdecimal'
require 'security'

class Buy

attr_reader :quantity

  def initialize(security, quantity, acquire_date, unit_cost)
    @security = security
    @quantity = BigDecimal(quantity)
    @acquire_date = acquire_date
    @unit_cost = BigDecimal(unit_cost)
  end

  # When this security was purchased, how much did it cost?
  def cost
    (@quantity * @unit_cost).round(2)
  end

  # Given today's market_price, what is this security worth?
  def market_value(market_price)
    (@quantity * BigDecimal(market_price)).round(2)
  end

  # If sold at today's market_price, what would the gain or loss be?
  def unrealized_gain_or_loss(market_price)
    market_value(market_price) - cost
  end

  # If sold at today's market_price, what would the gain or loss be in percent?
  def percent_gain_or_loss(market_price)
    (((market_value(market_price) - cost) / cost) * 100).round(2)
  end

  def months(today)
    if today.day >= @acquire_date.day
      months_without_days(today)
    else
      months_without_days(today) - 1
    end
  end

  private

  def months_without_days(today)
    (today.year * 12 + today.month) - (@acquire_date.year * 12 + @acquire_date.month)
  end

end

