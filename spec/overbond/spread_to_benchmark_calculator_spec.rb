require 'spec_helper'

module Overbond

  describe SpreadToBenchmarkCalculator do

    it 'can be created' do
      expect{ SpreadToBenchmarkCalculator.new() }.not_to raise_error
    end

    let( :calculator ) { SpreadToBenchmarkCalculator.new() }

    let( :bond ) { Bond.new( 'C1', 'corporate', 10.3, 5.3 ) }
    let( :benchmark ) { Bond.new( 'G1', 'government', 9.4, 3.7 ) }

    it 'calculates the difference between a bond and a benchmark' do
      expect( calculator.calculate( bond, benchmark ) ).to be_within( 0.01).of( 1.6 )
    end

  end

end

