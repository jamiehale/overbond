require 'spec_helper'

module Overbond
  describe BenchmarkSpreadReporter do
    it 'exists' do
      expect { BenchmarkSpreadReporter.new }.not_to raise_error
    end

    describe 'once created' do
      let(:reporter) { BenchmarkSpreadReporter.new }

      describe 'reporting' do
        let(:stream) { double('stream') }
        let(:valid_header) { 'bond,benchmark,spread_to_benchmark' }

        before(:each) do
          allow(stream).to receive(:puts).with(valid_header)
        end

        it 'outputs the report header' do
          expect(stream).to receive(:puts).with(valid_header)
          reporter.report(stream, [])
        end

        it 'outputs a line for each spread' do
          expect(stream).to receive(:puts).with('C1,G1,1.60%')
          spread = double('spread', to_csv: 'C1,G1,1.60%')
          reporter.report(stream, [spread])
        end
      end
    end
  end
end
