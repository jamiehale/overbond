require 'spec_helper'

module Overbond

  describe YieldCurveLeg do

    let( :benchmark1 ) { Bond.new( 'G1', 'government', 9.4, 3.7 ) }
    let( :benchmark2 ) { Bond.new( 'G2', 'government', 12, 4.8 ) }

    it 'exists' do
      expect{ YieldCurveLeg.new( benchmark1, benchmark2 ) }.not_to raise_error
    end

    describe 'once created' do

      let( :leg ) { YieldCurveLeg.new( benchmark1, benchmark2 ) }
      let( :bond ) { Bond.new( 'C1', 'corporate', 10.3, 5.3 ) }

      it 'knows the spread to a bond' do
        expect( leg.spread_from( bond ) ).to be_within( 0.001 ).of( 1.22 )
      end

    end

  end

end

