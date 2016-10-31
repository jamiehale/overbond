module Overbond
  ##
  # A spread from a bond yield to a curve (or anything technically).
  #
  class CurveSpread
    attr_reader :bond, :spread

    def initialize(bond, spread)
      @bond = bond
      @spread = spread
    end

    def to_csv
      format('%s,%.2f%%', @bond.id, @spread)
    end
  end
end
