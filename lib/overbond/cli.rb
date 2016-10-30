require 'thor'

module Overbond

  class CLI < Thor

    desc 'benchmark INPUT_FILE', 'Find the benchmarks in INPUT_FILE for all corporate bonds also in INPUT_FILE.'
    def benchmark( filename )
      BenchmarkCommand.new().run( File.open( filename ), STDOUT )
    end

  end

end

