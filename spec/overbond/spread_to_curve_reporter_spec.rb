require 'spec_helper'

module Overbond
  describe SpreadToCurveReporter do
    it 'exists' do
      expect { SpreadToCurveReporter.new }.not_to raise_error
    end

    describe 'once created' do
      let(:reporter) { SpreadToCurveReporter.new }

      describe 'reporting' do
        let(:stream) { StringIO.new }
        let(:valid_header) { 'bond,spread_to_curve' }

        describe 'an empty set' do
          before(:each) do
            reporter.report(stream, [])
          end

          it 'outputs a single line' do
            expect(stream.string.split("\n").count).to eq(1)
          end

          it 'outputs the report header' do
            expect(stream.string).to include(valid_header)
          end
        end

        describe 'a set of spreads' do
          let(:spread) { double('spread', to_csv: 'C1,1.22%') }

          before(:each) do
            reporter.report(stream, [spread])
          end

          it 'outputs 2 lines' do
            expect(stream.string.split("\n").count).to eq(2)
          end

          it 'outputs the report header' do
            expect(stream.string).to include(valid_header)
          end

          it 'outputs a line for each spread' do
            expect(stream.string).to include('C1,1.22%')
          end
        end
      end
    end
  end
end
