require 'spec_helper'

module Overbond
  describe BenchmarkFinder do
    it 'exists' do
      expect { BenchmarkFinder }.not_to raise_error
    end

    let(:finder) { BenchmarkFinder.new }

    let(:bond) { Bond.new('C1', 'corporate', 10.3, 5.3) }
    let(:benchmark1) { Bond.new('G1', 'government', 9.4, 3.7) }
    let(:benchmark2) { Bond.new('G2', 'government', 12, 4.8) }

    it 'returns a BenchmarkSpread' do
      expect(finder.find(bond, [benchmark1])).to be_instance_of(BenchmarkSpread)
    end

    it 'returns the only benchmark if only one is passed' do
      expect(finder.find(bond, [benchmark1]).benchmark).to eq(benchmark1)
    end

    it 'returns the closest benchmark when multiple candidates are passed' do
      expect(finder.find(bond, [benchmark2, benchmark1]).benchmark).to eq(benchmark1)
    end

    it 'returns the passed bond' do
      expect(finder.find(bond, [benchmark2, benchmark1]).bond).to eq(bond)
    end

    it 'throws if no candidates are passed' do
      expect { finder.find(bond, []) }.to raise_error(OverbondException)
    end
  end
end
