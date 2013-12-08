require 'spec_helper'

describe TickerPrice do
  it "should create a record" do
    expect {
      TickerPrice.create
    }.to change {TickerPrice.count}.by(1)
  end
end
