require 'thor'

module Overbond

  class CLI < Thor
    desc 'find_benchmark BOND_ID INPUT_FILE', 'Find the benchmark for BOND_ID'
    def find_benchmark( bond_id, input_filename )
      puts 'bond,benchmark,spread_to_benchmark'
    end
  end

end

