require 'spec_helper'

module Overbond
  describe BondFileLoader do
    it 'exists' do
      expect { BondFileLoader.new }.not_to raise_error
    end

    describe 'once created' do
      let(:loader) { BondFileLoader.new }
      let(:bond1) { Bond.new('C1', 'corporate', 1.3, 3.3) }
      let(:bond2) { Bond.new('C2', 'corporate', 2.0, 3.8) }
      let(:valid_header) { 'bond,type,term,yield' }

      describe 'with header only' do
        let(:stream) { StringIO.new(valid_header + "\n") }

        it 'returns a BondCollection' do
          expect(loader.load(stream)).to be_instance_of(BondCollection)
        end

        it 'returns an empty set' do
          expect(loader.load(stream)).to be_empty
        end
      end

      describe 'with a single well-formed line' do
        let(:stream) { StringIO.new(valid_header + "\n" + bond1.to_csv + "\n") }

        before(:each) do
          @bonds = loader.load(stream)
        end

        it 'returns a single element' do
          expect(@bonds.count).to eq(1)
        end

        it 'returns the proper element' do
          expect(@bonds[0]).to eq(bond1)
        end
      end

      describe 'with multiple well-formed lines' do
        let(:stream) { StringIO.new(valid_header + "\n" + bond1.to_csv + "\n" + bond2.to_csv + "\n") }

        before(:each) do
          @bonds = loader.load(stream)
        end

        it 'returns 2 elements' do
          expect(@bonds.count).to eq(2)
        end

        it 'returns the first element' do
          expect(@bonds[0]).to eq(bond1)
        end

        it 'returns the second element' do
          expect(@bonds[1]).to eq(bond2)
        end
      end

      describe 'error conditions' do
        it 'raises an error if the stream is empty' do
          expect { loader.load(StringIO.new) }.to raise_error(OverbondException)
        end

        it 'raises an error if the stream has no header' do
          expect { loader.load(StringIO.new(bond1.to_csv + "\n")) }.to raise_error(OverbondException)
        end

        describe 'with valid headers' do
          let(:stream) { StringIO.new }

          before(:each) do
            stream.puts(valid_header)
          end

          it 'raises an error if the term is malformed' do
            stream.puts('C1,corporate,6 months,3.30%')
            expect { loader.load(stream) }.to raise_error(OverbondException)
          end

          it 'raises an error if the term has too many tokens' do
            stream.puts('C1,corporate,6 and a half months,3.30%')
            expect { loader.load(stream) }.to raise_error(OverbondException)
          end

          it 'raises an error if the yield is malformed' do
            stream.puts('C1,corporate,1.6 years,3.30')
            expect { loader.load(stream) }.to raise_error(OverbondException)
          end
        end
      end
    end
  end
end
