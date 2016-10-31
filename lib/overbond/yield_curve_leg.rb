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
      bond.yield - interpolate_yield_at(bond.term)
    end

    private

    def interpolate_yield_at(term)
      @from.yield + scale(term) * @to.yield_delta(@from)
    end

    def scale(term)
      (term - @from.term) / (@to.term - @from.term)
    end
  end
end
