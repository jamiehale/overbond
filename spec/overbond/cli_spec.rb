require 'spec_helper'

module Overbond

  describe CLI do

    it 'exists' do
      expect{ CLI.new() }.not_to raise_error
    end

    describe 'benchmark command' do

      let( :command ) { double( :command ) }
      let( :input_stream ) { double( 'input stream' ) }

      before( :each ) do
        allow( File ).to receive( :open ).with( 'filename' ).and_return( input_stream )
        allow( BenchmarkCommand ).to receive( :new ).and_return( command )
        allow( command ).to receive( :run )
      end

      it 'opens the input file' do
        expect( File ).to receive( :open ).with( 'filename' )
        subject.benchmark( 'filename' )
      end

      it 'defers to the benchmark finder command' do
        expect( BenchmarkCommand ).to receive( :new ) { command }
        expect( command ).to receive( :run ).with( input_stream, STDOUT )
        subject.benchmark( 'filename' )
      end

    end

  end

end

