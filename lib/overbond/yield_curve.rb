module Overbond

  class YieldCurve

    class Leg
    
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

    def initialize( bonds )
      @bonds = bonds.sort { |a,b| a.term <=> b.term }
      @legs = build_legs
    end

    def empty?
      true
    end

    def spread_from( bond )
      leg = find_leg_from_term( bond.term )
      CurveSpread.new( bond, leg.spread_from( bond ) )
    end

    private

      def build_legs
        legs = []
        last_bond = nil
        @bonds.each do |bond|
          if last_bond.nil?
            last_bond = bond
          else
            legs << Leg.new( last_bond, bond )
            last_bond = bond
          end
        end
        legs
      end

      def find_leg_from_term( term )
        @legs.find { |l| term >= l.from.term and term <= l.to.term }
      end

  end

end

