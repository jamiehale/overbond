module Overbond
  ##
  # The command for finding benchmarks from an input stream and reporting
  # to an output stream.
  #
  class BenchmarkCommand
    def initialize(options = {})
      @loader = options[:loader] || BondFileLoader.new
      @finder = options[:finder] || BenchmarkFinder.new
      @reporter = options[:reporter] || BenchmarkSpreadReporter.new
    end

    def run(input_stream, output_stream)
      bonds = @loader.load(input_stream)
      results = []
      bonds.each('corporate') do |bond|
        results << @finder.find(bond, bonds.all('government'))
      end
      @reporter.report(output_stream, results)
    end
  end
end
