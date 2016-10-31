require 'spec_helper'

module Overbond
  describe BondFileLoader do
    it 'exists' do
      expect { BondFileLoader.new }.not_to raise_error
    end

    describe 'once created' do
      let(:loader) { BondFileLoader.new }
      let(:stream) { double('stream') }
      let(:bond1) { Bond.new('C1', 'corporate', 1.3, 3.3) }
      let(:bond2) { Bond.new('C2', 'corporate', 2.0, 3.8) }
      let(:valid_header) { 'bond,type,term,yield' }

      it 'calls gets for header line then each_line for remainder of file' do
        expect(stream).to receive(:gets).and_return(valid_header).ordered
        expect(stream).to receive(:each_line).ordered
        loader.load(stream)
      end

      describe 'with a valid header' do
        before(:each) do
          allow(stream).to receive(:gets).and_return(valid_header)
        end

        it 'returns a BondCollection' do
          allow(stream).to receive(:each_line)
          expect(loader.load(stream)).to be_instance_of(BondCollection)
        end

        it 'returns an empty collection if the passed stream has no bonds' do
          allow(stream).to receive(:each_line)
          expect(loader.load(stream)).to be_empty
        end

        it 'returns a single element for a single well-formed line' do
          allow(stream).to receive(:each_line).and_yield(bond1.to_csv + "\n")
          bonds = loader.load(stream)
          expect(bonds.count).to eq(1)
          expect(bonds[0]).to eq(bond1)
        end

        it 'returns multiple elements for multiple well-formed lines' do
          allow(stream).to receive(:each_line)
            .and_yield(bond1.to_csv + "\n")
            .and_yield(bond2.to_csv + "\n")
          bonds = loader.load(stream)
          expect(bonds.count).to eq(2)
          expect(bonds[0]).to eq(bond1)
          expect(bonds[1]).to eq(bond2)
        end
      end

      describe 'error conditions' do
        it 'raises an error if the stream is empty' do
          allow(stream).to receive(:gets).and_return(nil)
          expect { loader.load(stream) }.to raise_error(OverbondException)
        end

        it 'raises an error if the stream has no header' do
          allow(stream).to receive(:gets)
            .and_return('C1,corporate,1.3 years,3.30%')
          expect { loader.load(stream) }.to raise_error(OverbondException)
        end

        describe 'with valid headers' do
          before(:each) do
            allow(stream).to receive(:gets).and_return(valid_header)
          end

          it 'raises an error if the term is malformed' do
            allow(stream).to receive(:each_line)
              .and_yield('C1,corporate,6 months,3.30%')
            expect { loader.load(stream) }.to raise_error(OverbondException)
          end

          it 'raises an error if the term has too many tokens' do
            allow(stream).to receive(:each_line)
              .and_yield('C1,corporate,6 and a half months,3.30%')
            expect { loader.load(stream) }.to raise_error(OverbondException)
          end

          it 'raises an error if the yield is malformed' do
            allow(stream).to receive(:each_line)
              .and_yield('C1,corporate,1.6 years,3.30')
            expect { loader.load(stream) }.to raise_error(OverbondException)
          end
        end
      end
    end
  end
end
