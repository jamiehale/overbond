module Overbond

  class BenchmarkFinder

    def find( bond, candidates )
      benchmark = nil
      candidates.each do |candidate|
        if benchmark.nil?
          benchmark = candidate
        else
          if bond.term_delta( candidate ) < bond.term_delta( benchmark )
            benchmark = candidate
          end
        end
      end
      benchmark
    end

  end

end

