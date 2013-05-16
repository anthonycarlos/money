require 'spec_helper'

describe Buy do
  describe "#cost" do
    it "calculates cost" do
      security = Security.new('YAFFX', 'Yacktman Focused Fund', '23.3900', Date.new(2013, 5, 15))
      buy = Buy.new(security, '137.6650', Date.new(2011, 8, 17), '18.1600')
      buy.cost.should == BigDecimal('2500')
    end
  end
end
