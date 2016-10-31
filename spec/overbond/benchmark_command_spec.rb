require 'spec_helper'

module Overbond
  describe BenchmarkCommand do
    it 'exists' do
      expect { BenchmarkCommand.new }.not_to raise_error
    end

    it 'creates a new BondFileLoader if none is passed' do
      expect(BondFileLoader).to receive(:new)
      BenchmarkCommand.new
    end

    it 'uses the passed BondFileLoader' do
      expect(BondFileLoader).not_to receive(:new)
      BenchmarkCommand.new(loader: double('loader'))
    end

    it 'creates a new BenchmarkSpreadReporter if none is passed' do
      expect(BenchmarkSpreadReporter).to receive(:new)
      BenchmarkCommand.new
    end

    it 'uses the passed BenchmarkSpreadReporter' do
      expect(BenchmarkSpreadReporter).not_to receive(:new)
      BenchmarkCommand.new(reporter: double('reporter'))
    end

    it 'creates a new BenchmarkFinder if none is passed' do
      expect(BenchmarkFinder).to receive(:new)
      BenchmarkCommand.new
    end

    it 'uses the passed BenchmarkFinder' do
      expect(BenchmarkFinder).not_to receive(:new)
      BenchmarkCommand.new(finder: double('finder'))
    end

    describe 'once created' do
      let(:loader) { double('loader') }
      let(:finder) { double('finder') }
      let(:reporter) { double('reporter') }
      let(:command) { BenchmarkCommand.new(loader: loader, finder: finder, reporter: reporter) }
      let(:bonds) { double('bond collection') }
      let(:input_stream) { double('input stream') }
      let(:output_stream) { double('output stream') }
      let(:bond) { double('bond') }
      let(:benchmarks) { double('benchmarks') }
      let(:spread) { double('spread') }

      before(:each) do
        allow(loader).to receive(:load).and_return(bonds)
        allow(bonds).to receive(:each)
        allow(bonds).to receive(:all).and_return(benchmarks)
        allow(finder).to receive(:find).and_return(spread)
        allow(reporter).to receive(:report)
      end

      it 'loads bonds from the given filename' do
        expect(loader).to receive(:load).and_return(bonds)
        command.run(input_stream, output_stream)
      end

      it 'defers to the benchmark finder for each non-benchmark bond' do
        allow(bonds).to receive(:each).and_yield(bond)
        expect(finder).to receive(:find).with(bond, benchmarks)
        command.run(input_stream, output_stream)
      end

      it 'defers to the reporter for output' do
        allow(bonds).to receive(:each).and_yield(bond)
        expect(reporter).to receive(:report).with(output_stream, [spread])
        command.run(input_stream, output_stream)
      end
    end
  end
end
