module Overbond
  ##
  # The command for calculating the spread to a curve from a bond and
  # reporting to an output stream.
  class SpreadToCurveCommand
    def initialize(options = {})
      @loader = options[:loader] || BondFileLoader.new
      @reporter = options[:reporter] || SpreadToCurveReporter.new
    end

    def run(input_stream, output_stream)
      bonds = @loader.load(input_stream)
      curve = YieldCurve.new(bonds.all('government'))
      results = []
      bonds.each('corporate') do |bond|
        results << curve.spread_from(bond)
      end
      @reporter.report(output_stream, results)
    end
  end
end
