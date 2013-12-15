require 'spec_helper'

describe Trade do
  describe "validations" do

    it "should not allow random transaction types" do
      trade = Trade.new(transaction_type: 'foo')
      trade.should_not be_valid
      trade.transaction_type = "buy"
      trade.should be_valid
    end

    it "should not allow negative buy/sell amounts" do
      trade = FactoryGirl.build(:trade)
      trade.buy_amount = -1425
      trade.sell_amount = -1425
      trade.should_not be_valid
    end

    it "should not allow non numeric buy/sell amounts" do
      trade = FactoryGirl.build(:trade)
      trade.buy_amount = "foo"
      trade.sell_amount = "bar"
      trade.should_not be_valid
    end
  end

  describe "#convert_values" do
    let(:trade) { FactoryGirl.create(:trade, buy_amount: 1, sell_amount: 1) }

    it "should convert values to hundreth of a cent" do
      trade.buy_amount.should == 100000
      trade.sell_amount.should == 100000
    end

    it "should convert values on update" do
      trade.update_attributes(buy_amount: 2, sell_amount: 4)
      trade.buy_amount.should == 200000
      trade.sell_amount.should == 400000
    end

    it "double saves should not break" do
      trade.buy_amount.should == 100000
      trade.sell_amount.should == 100000
      trade.save
      trade.buy_amount.should == 100000
      trade.sell_amount.should == 100000
    end

  end

  describe "#status" do
    let(:trade) { FactoryGirl.create(:trade) }

    it "should be unconfirmed if no confirmed at and completed at" do
      trade.status.downcase.should include "unconfirmed"
    end

    it "should be pending if there is a confirmed at" do
      trade.update_attribute(:confirmed_at, Time.now)
      trade.status.downcase.should include "pending"
    end

    it "should be completed if there is a confirmed_at and completed_at" do
      trade.update_attributes(confirmed_at: Time.now, completed_at: Time.now)
      trade.status.downcase.should include "completed"
    end
  end

  describe "#confirm!" do
    let(:trade) { FactoryGirl.create(:trade, buy_amount: 1, sell_amount: 1) }

    it "should confirm the trade" do
      trade.should_not be_confirmed_at
      trade.confirm!
      trade.should be_confirmed_at
    end

    it "should prevent double confirmation" do
      trade.should_not be_confirmed_at
      trade.confirm!
      trade.should be_confirmed_at

      trade.confirm!
      trade.errors.full_messages.join.downcase.should include "trade is already confirmed"
    end

    it "should not be able to update" do
      trade.confirm!
      trade.buy_amount.should == 100000
      trade.sell_amount.should == 100000
      trade.update_attributes(buy_amount: 4, sell_amount: 4)
      trade.buy_amount.should == 100000
      trade.sell_amount.should == 100000
    end


  end
end
