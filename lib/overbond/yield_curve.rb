module Overbond
  ##
  # A collection of bonds representing a curve, made up of legs from one
  # bond to another.
  #
  class YieldCurve
    def initialize(bonds)
      @bonds = bonds.sort_by(&:term)
      @legs = build_legs
    end

    def empty?
      true
    end

    def spread_from(bond)
      leg = find_leg_from_term(bond.term)
      CurveSpread.new(bond, leg.spread_from(bond))
    end

    private

    def build_legs
      legs = []
      last_bond = nil
      @bonds.each do |bond|
        legs << YieldCurveLeg.new(last_bond, bond) unless last_bond.nil?
        last_bond = bond
      end
      legs
    end

    def find_leg_from_term(term)
      @legs.find { |l| term >= l.from.term && term <= l.to.term }
    end
  end
end
