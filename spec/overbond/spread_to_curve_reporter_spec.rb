require 'spec_helper'

module Overbond

  describe SpreadToCurveReporter do

    it 'exists' do
      expect{ SpreadToCurveReporter.new() }.not_to raise_error
    end

    describe 'once created' do

      let( :reporter ) { SpreadToCurveReporter.new() }

      describe 'reporting' do

        let( :stream ) { double( 'stream' ) }
        let( :valid_header ) { 'bond,spread_to_curve' }

        before( :each ) { allow( stream ).to receive( :puts ).with( valid_header ) }

        it 'outputs the report header' do
          expect( stream ).to receive( :puts ).with( valid_header )
          reporter.report( stream, [] )
        end

        it 'outputs a line for each spread' do
          expect( stream ).to receive( :puts ).with( 'C1,1.22%' )
          spread = double( 'spread', :to_csv => 'C1,1.22%' )
          reporter.report( stream, [ spread ] )
        end

      end

    end

  end

end
