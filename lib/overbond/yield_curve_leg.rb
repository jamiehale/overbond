module Overbond

  class YieldCurveLeg
  
    attr_reader :from, :to

    def initialize( from, to )
      @from = from
      @to = to
    end

    def spread_from( bond )
      scale = ( bond.term - @from.term ) / ( @to.term - @from.term )
      yield_on_curve = @from.yield + scale * ( @to.yield - @from.yield )
      bond.yield - yield_on_curve
    end

  end

end

