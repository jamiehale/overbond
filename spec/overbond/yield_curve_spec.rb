require 'spec_helper'

module Overbond
  describe YieldCurve do
    it 'exists' do
      expect { YieldCurve.new([]) }.not_to raise_error
    end

    describe 'once created' do
      let(:curve) { YieldCurve.new([]) }
      let(:bond) { Bond.new('C1', 'corporate', 10.3, 5.3) }

      it 'is empty' do
        expect(curve).to be_empty
      end

      describe 'when calculating spread from a bond' do
        let(:benchmark1) { Bond.new('G1', 'government', 9.4, 3.7) }
        let(:benchmark2) { Bond.new('G2', 'government', 12, 4.8) }

        describe 'when the curve has a single leg' do
          let(:curve) { YieldCurve.new([benchmark1, benchmark2]) }

          it 'returns a CurveSpread' do
            expect(curve.spread_from(bond)).to be_instance_of(CurveSpread)
          end

          it 'calculates the spread to the linear interpolated point on the single leg' do
            expect(curve.spread_from(bond).spread).to be_within(0.01).of(1.22)
          end
        end

        describe 'when the curve has multiple legs' do
          let(:benchmark3) { Bond.new('G3', 'government', 16.3, 5.5) }
          let(:curve) { YieldCurve.new([benchmark1, benchmark2, benchmark3]) }

          it 'calculates the spread to the linear interpolated point on the appropriate leg' do
            expect(curve.spread_from(bond).spread).to be_within(0.01).of(1.22)
          end
        end

        describe 'when the curve has multiple legs defined out of order' do
          let(:benchmark3) { Bond.new('G3', 'government', 16.3, 5.5) }
          let(:curve) { YieldCurve.new([benchmark2, benchmark1, benchmark3]) }

          it 'calculates the spread to the linear interpolated point on the appropriate leg' do
            expect(curve.spread_from(bond).spread).to be_within(0.01).of(1.22)
          end
        end
      end
    end
  end
end
