module Overbond
  ##
  # Stores one "leg" of a yield curve from one bond to the next.
  #
  class YieldCurveLeg
    attr_reader :from, :to

    def initialize(from, to)
      @from = from
      @to = to
    end

    def spread_from(bond)
      bond.yield - (@from.yield + scale(bond) * @to.yield_delta(@from))
    end

    private

    def scale(bond)
      (bond.term - @from.term) / (@to.term - @from.term)
    end
  end
end
