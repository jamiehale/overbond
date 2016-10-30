require 'spec_helper'

module Overbond

  describe SpreadToCurveCommand do

    it 'exists' do
      expect{ SpreadToCurveCommand.new() }.not_to raise_error
    end
    
    it 'creates a new BondFileLoader if none is passed' do
      expect( BondFileLoader ).to receive( :new )
      SpreadToCurveCommand.new()
    end

    it 'uses the passed BondFileLoader' do
      expect( BondFileLoader ).not_to receive( :new )
      SpreadToCurveCommand.new( :loader => double( 'loader' ) )
    end

    it 'creates a new SpreadToCurveReporter if none is passed' do
      expect( SpreadToCurveReporter ).to receive( :new )
      SpreadToCurveCommand.new()
    end

    it 'uses the passed SpreadToCurveReporter' do
      expect( SpreadToCurveReporter ).not_to receive( :new )
      SpreadToCurveCommand.new( :reporter => double( 'reporter' ) )
    end

    describe 'once created' do

      let( :loader ) { double( 'loader' ) }
      let( :reporter ) { double( 'reporter' ) }
      let( :command ) { SpreadToCurveCommand.new( :loader => loader, :reporter => reporter ) }
      let( :bonds ) { double( 'bond collection' ) }
      let( :curve ) { double( 'curve' ) }
      let( :input_stream ) { double( 'input stream' ) }
      let( :output_stream ) { double( 'output stream' ) }
      let( :bond ) { double( 'bond' ) }
      let( :benchmarks ) { double( 'benchmarks' ) }
      let( :spread ) { double( 'curve spread' ) }

      before( :each ) do
        allow( loader ).to receive( :load ).and_return( bonds )
        allow( bonds ).to receive( :all ).and_return( benchmarks )
        allow( YieldCurve ).to receive( :new ).and_return( curve )
        allow( bonds ).to receive( :each )
        allow( curve ).to receive( :spread_from ).and_return( spread )
        allow( reporter ).to receive( :report )
      end

      it 'loads bonds from the given filename' do
        expect( loader ).to receive( :load ).and_return( bonds )
        command.run( input_stream, output_stream )
      end

      it 'creates a yield curve from all government bonds' do
        expect( YieldCurve ).to receive( :new ).with( benchmarks )
        command.run( input_stream, output_stream )
      end

      it 'defers to the curve to calculate the spread for each corporate bond' do
        allow( bonds ).to receive( :each ).and_yield( bond )
        expect( curve ).to receive( :spread_from ).with( bond )
        command.run( input_stream, output_stream )
      end

      it 'defers to the reporter for output' do
        allow( bonds ).to receive( :each ).and_yield( bond )
        expect( reporter ).to receive( :report ).with( output_stream, [ spread ] )
        command.run( input_stream, output_stream )
      end

    end

  end

end
