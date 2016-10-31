require 'spec_helper'

module Overbond
  describe YieldCurveLeg do
    let(:benchmark1) { Bond.new('G1', 'government', 9.4, 3.7) }
    let(:benchmark2) { Bond.new('G2', 'government', 12, 4.8) }
    let(:benchmark3) { Bond.new('G3', 'government', 16.3, 5.5) }
    let(:bond1) { Bond.new('C1', 'corporate', 10.3, 5.3) }
    let(:bond2) { Bond.new('C2', 'corporate', 15.2, 8.3) }

    it 'exists' do
      expect { YieldCurveLeg.new(benchmark1, benchmark2) }.not_to raise_error
    end

    describe 'calculating spread to a bond' do
      [
        {
          bond: Bond.new('C1', 'corporate', 10.3, 5.3),
          benchmark_from: Bond.new('G1', 'government', 9.4, 3.7),
          benchmark_to: Bond.new('G2', 'goverment', 12, 4.8),
          spread: 1.22
        },
        {
          bond: Bond.new('C2', 'corporate', 15.2, 8.3),
          benchmark_from: Bond.new('G2', 'government', 12, 4.8),
          benchmark_to: Bond.new('G3', 'government', 16.3, 5.5),
          spread: 2.98
        }
      ].each do |d|
        it "calculates the spread to #{d[:bond].to_csv}" do
          leg = YieldCurveLeg.new(d[:benchmark_from], d[:benchmark_to])
          expect(leg.spread_from(d[:bond])).to be_within(0.001).of(d[:spread])
        end
      end
    end
  end
end
