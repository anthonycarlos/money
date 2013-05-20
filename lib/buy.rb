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

  def cmgr(market_price, months)
    market_value_f = market_value(market_price).to_f
    cost_f = cost.to_f
    months_f = months.to_f
    result_f = (((market_value_f - cost_f) / cost_f) + 1.0) ** (1.0 / months_f)
    result_bd = BigDecimal.new(result_f.to_s)
    result_bd
  end

  def cmgr_percent(market_price, months)
    (cmgr(market_price, months) - 1) * 100
  end

  private

  def months_without_days(today)
    (today.year * 12 + today.month) - (@acquire_date.year * 12 + @acquire_date.month)
  end

end

