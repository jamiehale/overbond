module Overbond
  ##
  # A collection of bonds representing a curve, made up of legs from one
  # bond to another.
  #
  class YieldCurve
    def initialize(bonds)
      @legs = build_legs(bonds.sort_by(&:term))
    end

    def empty?
      @legs.empty?
    end

    def spread_from(bond)
      leg = find_leg_from_term(bond.term)
      CurveSpread.new(bond, leg.spread_from(bond))
    end

    private

    def build_legs(bonds)
      legs = []
      previous_bond = nil
      bonds.each do |bond|
        legs << YieldCurveLeg.new(previous_bond, bond) unless previous_bond.nil?
        previous_bond = bond
      end
      legs
    end

    def find_leg_from_term(term)
      @legs.find { |l| term >= l.from.term && term <= l.to.term }
    end
  end
end
