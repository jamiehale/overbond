module Overbond
  ##
  # Reporter generating output from CurveSpreads.
  #
  class SpreadToCurveReporter
    def report(output_stream, spreads)
      output_stream.puts(header)
      spreads.each do |spread|
        output_stream.puts(spread.to_csv)
      end
    end

    private

    def header
      'bond,spread_to_curve'
    end
  end
end
