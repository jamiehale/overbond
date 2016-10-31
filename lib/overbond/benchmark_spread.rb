module Overbond
  ##
  # The yield spread from a bond to a benchmark bond.
  #
  class BenchmarkSpread
    attr_reader :bond, :benchmark

    def initialize(bond, benchmark)
      @bond = bond
      @benchmark = benchmark
    end

    def spread
      @bond.yield_delta(@benchmark)
    end

    def to_csv
      format('%s,%s,%.2f%%', @bond.id, @benchmark.id, spread)
    end
  end
end
