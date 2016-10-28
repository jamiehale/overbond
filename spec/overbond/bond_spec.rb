require 'spec_helper'

module Overbond

  describe Overbond::Bond do

    it 'is creatable with an identifier, type, term, and yield' do
      expect{ Bond.new( 'C1', 'corporate', 10.3, 5.3 ) }.not_to raise_error
    end

    describe 'once created' do

      let( :bond ) { Bond.new( 'C1', 'corporate', 10.3, 5.3 ) }

      it 'knows its identifier' do
        expect( bond.id ).to eq( 'C1' )
      end

      it 'knows its type' do
        expect( bond.type ).to eq( 'corporate' )
      end

      it 'knows its term' do
        expect( bond.term ).to eq( 10.3 )
      end

      it 'knows its yield' do
        expect( bond.yield ).to eq( 5.3 )
      end

    end

  end

end
