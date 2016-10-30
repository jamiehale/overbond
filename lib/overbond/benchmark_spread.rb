module Overbond

  class BenchmarkSpread

    attr_reader :bond, :benchmark

    def initialize( bond, benchmark )
      @bond = bond
      @benchmark = benchmark
    end

    def spread
      ( @bond.yield - @benchmark.yield ).abs
    end

    def to_csv
      "%s,%s,%.2f%%" % [ @bond.id, @benchmark.id, spread ]
    end

  end

end

