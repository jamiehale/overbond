require 'thor'

module Overbond
  ##
  # The Thor-based multi-command CLI interface.
  #
  class CLI < Thor
    desc 'benchmark INPUT_FILE', <<-eos
      Find the benchmarks in INPUT_FILE for all corporate bonds also in
      INPUT_FILE.
      eos
    def benchmark(filename)
      BenchmarkCommand.new.run(File.open(filename), STDOUT)
    end

    desc 'spread_to_curve INPUT_FILE', <<-eos
      Finds the spread to the benchmark yield curve (from INPUT_FILE) for
      each corporate bond in INPUT_FILE.
      eos
    def spread_to_curve(filename)
      SpreadToCurveCommand.new.run(File.open(filename), STDOUT)
    end
  end
end
