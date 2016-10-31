require 'spec_helper'

module Overbond
  describe BenchmarkSpread do
    let(:bond) { Bond.new('C1', 'corporate', 10.3, 5.3) }
    let(:benchmark) { Bond.new('G1', 'government', 9.4, 3.7) }

    it 'is creatable with bond and benchmark' do
      expect { BenchmarkSpread.new(bond, benchmark) }.not_to raise_error
    end

    describe 'once created' do
      let(:spread) { BenchmarkSpread.new(bond, benchmark) }

      it 'knows its bond' do
        expect(spread.bond).to eq(bond)
      end

      it 'knows its benchmark' do
        expect(spread.benchmark).to eq(benchmark)
      end

      it 'knows its spread' do
        expect(spread.spread).to eq(bond.yield - benchmark.yield)
      end

      it 'converts to csv' do
        expect(spread.to_csv).to eq('C1,G1,1.60%')
      end
    end
  end
end
