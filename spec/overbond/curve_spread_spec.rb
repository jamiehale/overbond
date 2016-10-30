require 'spec_helper'

module Overbond

  describe CurveSpread do

    let( :bond ) { Bond.new( 'C1', 'corporate', 10.3, 5.2 ) }
    let( :spread ) { 1.22 }

    it 'is created with a bond and a spread' do
      expect{ CurveSpread.new( bond, spread ) }.not_to raise_error
    end

    describe 'once created' do

      let( :curve_spread ) { CurveSpread.new( bond, spread ) }

      it 'knows its bond' do
        expect( curve_spread.bond ).to eq( bond )
      end

      it 'knows its spread' do
        expect( curve_spread.spread ).to eq( spread )
      end

      it 'converts to csv' do
        expect( curve_spread.to_csv ).to eq( 'C1,1.22%' )
      end

    end

  end

end

