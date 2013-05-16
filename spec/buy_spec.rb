require 'spec_helper'

describe Buy do

  Given(:security) { security = Security.new('YAFFX', 'Yacktman Focused Fund') }
  Given(:subject) { Buy.new(security, '137.6650', Date.new(2011, 8, 17), '18.1600') }
  Given(:market_value) { '23.3900' }

  describe "#cost" do
    When(:result) { subject.cost }
    Then { result.should == BigDecimal('2500.00') }
  end

  describe "#market_value" do
    When(:result) { subject.market_value(market_value) }
    Then { result.should == BigDecimal('3219.98') }
  end

  describe "#unrealized_gain_or_loss" do
    When(:result) { subject.unrealized_gain_or_loss(market_value) }
    Then { result.should == BigDecimal('719.98') }
  end

  describe "#percent_gain_or_loss" do
    When(:result) { subject.percent_gain_or_loss(market_value) }
    Then { result.should == BigDecimal('28.80') }
  end

end
