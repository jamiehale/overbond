require 'thor'

module Overbond

  class CLI < Thor

    desc 'benchmark INPUT_FILE', 'Find the benchmarks in INPUT_FILE for all corporate bonds also in INPUT_FILE.'
    def benchmark( filename )
      BenchmarkCommand.new().run( File.open( filename ), STDOUT )
    end

    desc 'spread_to_curve INPUT_FILE', 'Finds the spread to the benchmark yield curve (from INPUT_FILE) for each corporate bond in INPUT_FILE.'
    def spread_to_curve( filename )
      SpreadToCurveCommand.new().run( File.open( filename ), STDOUT )
    end

  end

end

