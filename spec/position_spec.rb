require 'spec_helper'

describe Position do

  Given(:security) { security = Security.new('YAFFX', 'Yacktman Focused Fund') }
  Given(:market_price) { '23.3900' }
  Given(:buys) do
    [
      Buy.new(security, '137.6650', Date.new(2011,  8, 17), '18.1600'),
      Buy.new(security,   '0.8660', Date.new(2011, 12, 29), '18.8337'),
      Buy.new(security,   '0.2790', Date.new(2011, 12, 29), '18.8172'),
      Buy.new(security,   '0.3960', Date.new(2011, 12, 29), '18.8131'),
      Buy.new(security,   '0.5060', Date.new(2012,  6, 27), '19.6245'),
      Buy.new(security,   '0.2350', Date.new(2012,  6, 27), '19.5745'),
      Buy.new(security,   '0.6260', Date.new(2012, 12, 26), '20.4952'),
      Buy.new(security,   '0.2950', Date.new(2012, 12, 26), '20.5085')
    ]
  end
  Given(:subject) { Position.new(security, market_price, Date.new(2013, 5, 15), *buys) }

  describe "#quantity" do
    When(:result) { subject.quantity }
    Then { result.should == BigDecimal('140.8680') }
  end

  describe "#cost" do
    When(:result) { subject.cost }
    Then { result.should == BigDecimal('2562.42') }
  end

  describe "#market_value" do
    When(:result) { subject.market_value }
    Then { result.should == BigDecimal('3294.90') }
  end

  describe "#market_value_by_sum" do
    When(:result) { subject.market_value_by_sum(market_price) }
    Then { result.should be_within(0.01).of(BigDecimal('3294.90')) }
  end

  describe "#unrealized_gain_or_loss" do
    When(:result) { subject.unrealized_gain_or_loss }
    Then { result.should == BigDecimal('732.48') }
  end

  describe "#percent_gain_or_loss" do
    When(:result) { subject.percent_gain_or_loss }
    Then { result.should == BigDecimal('28.59') }
  end

  describe "#average_unit_cost" do
    When(:result) { subject.average_unit_cost }
    Then { result.should == BigDecimal('18.1902') }
  end

end

