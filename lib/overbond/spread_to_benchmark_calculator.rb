module Overbond

  class SpreadToBenchmarkCalculator

    def calculate( bond, benchmark )
      bond.yield - benchmark.yield
    end

  end

end

