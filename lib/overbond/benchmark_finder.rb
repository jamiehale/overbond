module Overbond
  ##
  # Finds the benchmark closest in term to a bond.
  #
  class BenchmarkFinder
    def find(bond, candidates)
      raise(OverbondException, 'No candidates found') if candidates.empty?
      benchmark = nil
      candidates.each do |candidate|
        if benchmark.nil?
          benchmark = candidate
        elsif bond.term_delta(candidate) < bond.term_delta(benchmark)
          benchmark = candidate
        end
      end
      BenchmarkSpread.new(bond, benchmark)
    end
  end
end
