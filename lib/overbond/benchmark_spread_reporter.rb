module Overbond
  ##
  # Reporter generating output from a list of BenchmarkSpreads.
  #
  class BenchmarkSpreadReporter
    def report(output_stream, spreads)
      output_stream.puts(header)
      spreads.each do |spread|
        output_stream.puts(spread.to_csv)
      end
    end

    private

    def header
      'bond,benchmark,spread_to_benchmark'
    end
  end
end
