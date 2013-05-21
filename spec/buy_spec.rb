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

  describe "#months" do
    When(:result) { subject.months(today) }
    context "exactly 1 year later" do
      Given(:today) { Date.new(2012, 8, 17) }
      Then { result.should == 12 }
    end
    context "1 year minus a day later" do
      Given(:today) { Date.new(2012, 8, 16) }
      Then { result.should == 11 }
    end
    context "1 year plus 1 month later" do
      Given(:today) { Date.new(2012, 9, 17) }
      Then { result.should == 13 }
    end
    context "1 year plus 1 month minus a day later" do
      Given(:today) { Date.new(2012, 9, 16) }
      Then { result.should == 12 }
    end
  end

  describe "#cmgr" do
    Given(:market_value) { '24.4300' }
    Given(:today) { Date.new(2013, 5, 19) }
    When(:result) { subject.cmgr(market_value, subject.months(today)) }
    Then { result.should be_within(0.0001).of(BigDecimal('1.0142')) }
  end

  describe "#cmgr_percent" do
    Given(:market_value) { '24.4300' }
    Given(:today) { Date.new(2013, 5, 19) }
    When(:result) { subject.cmgr_percent(market_value, subject.months(today)) }
    Then { result.should be_within(0.001).of(BigDecimal('1.422')) }
  end

  describe "#cagr" do
    Given(:market_value) { '24.4300' }
    Given(:today) { Date.new(2013, 5, 19) }
    When(:result) { subject.cagr(market_value, subject.months(today)) }
    Then { result.should be_within(0.0001).of(BigDecimal('1.1847')) }
  end

  describe "#cagr_percent" do
    Given(:market_value) { '24.4300' }
    Given(:today) { Date.new(2013, 5, 19) }
    When(:result) { subject.cagr_percent(market_value, subject.months(today)) }
    Then { result.should be_within(0.001).of(BigDecimal('18.469')) }
  end

end
