require 'spec_helper'

module Overbond
  describe BondCollection do
    it 'exists' do
      expect { BondCollection.new }.not_to raise_error
    end

    describe 'once created empty' do
      let(:collection) { BondCollection.new }

      it 'is empty' do
        expect(collection).to be_empty
      end

      it 'has a 0 count' do
        expect(collection.count).to eq(0)
      end

      describe 'adding a bond' do
        let(:bond) { Bond.new('C1', 'corporate', 10.3, 5.3) }

        before(:each) do
          collection << bond
        end

        it 'is no longer empty' do
          expect(collection).not_to be_empty
        end

        it 'has a 1 count' do
          expect(collection.count).to eq(1)
        end

        it 'can index the new bond' do
          expect(collection[0]).to eq(bond)
        end

        describe 'adding another' do
          let(:bond2) { Bond.new('C2', 'corporate', 4.3, 9.3) }

          before(:each) do
            collection << bond2
          end

          it 'is still not empty' do
            expect(collection).not_to be_empty
          end

          it 'has a 2 count' do
            expect(collection.count).to eq(2)
          end

          it 'can index both the old bond and the new one' do
            expect(collection[0]).to eq(bond)
            expect(collection[1]).to eq(bond2)
          end
        end
      end

      describe 'iterating' do
        let(:bond1) { Bond.new('C1', 'corporate', 10.3, 5.3) }
        let(:bond2) { Bond.new('C2', 'corporate', 7.4, 4.2) }
        let(:bond3) { Bond.new('G1', 'government', 6.5, 2.1) }

        before(:each) do
          collection << bond1
          collection << bond2
          collection << bond3
        end

        it 'responds to each' do
          count = 0
          collection.each('corporate') do |bond|
            expect(bond).to eq(bond1) if count == 0
            expect(bond).to eq(bond2) if count == 1
            expect(count).not_to eq(2)
            count += 1
          end
        end

        it 'responds to all' do
          bonds = collection.all('corporate')
          expect(bonds.count).to eq(2)
          expect(bonds[0]).to eq(bond1)
          expect(bonds[1]).to eq(bond2)
        end
      end
    end
  end
end
