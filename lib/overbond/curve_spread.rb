module Overbond

  class CurveSpread

    attr_reader :bond, :spread

    def initialize( bond, spread )
      @bond = bond
      @spread = spread
    end

    def to_csv
      "%s,%.2f%%" % [ @bond.id, @spread ]
    end

  end

end

