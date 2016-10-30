require 'spec_helper'

module Overbond

  describe CLI do

    it 'exists' do
      expect{ CLI.new() }.not_to raise_error
    end

    describe 'find_benchmarks command' do

      let( :command ) { double( :command ) }
      let( :input_stream ) { double( 'input stream' ) }

      before( :each ) do
        allow( File ).to receive( :open ).with( 'filename' ).and_return( input_stream )
        allow( FindBenchmarksCommand ).to receive( :new ).and_return( command )
        allow( command ).to receive( :run )
      end

      it 'opens the input file' do
        expect( File ).to receive( :open ).with( 'filename' )
        subject.find_benchmarks( 'filename' )
      end

      it 'defers to the benchmark finder command' do
        expect( FindBenchmarksCommand ).to receive( :new ) { command }
        expect( command ).to receive( :run ).with( input_stream, STDOUT )
        subject.find_benchmarks( 'filename' )
      end

    end

  end

end

