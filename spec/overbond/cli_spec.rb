require 'spec_helper'

module Overbond

  describe CLI do

    it 'exists' do
      expect{ CLI.new() }.not_to raise_error
    end

    describe 'find_benchmark command' do

      it 'outputs' do
        expect{ subject.find_benchmark( 'C1', 'filename' ) }.to output( /bond,benchmark,spread_to_benchmark/ ).to_stdout
      end

      it 'loads bonds from the file' do
        expect(BondFileLoader).to receive( :load ).with( 'filename' ) { [] }
        subject.find_benchmark( 'C1', 'filename' )
      end

    end

  end

end

