require 'thor'

module Overbond

  class CLI < Thor

    desc 'find_benchmarks INPUT_FILE', 'Find the benchmarks in INPUT_FILE for all corporate bonds also in INPUT_FILE.'
    def find_benchmarks( filename )
      FindBenchmarksCommand.new().run( File.open( filename ), STDOUT )
    end

  end

end

