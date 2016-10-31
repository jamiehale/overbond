module Overbond
  ##
  # A bond, including an identifier, a type ('corporate' or 'government')
  # a term in years, and a yield in %.
  #
  class Bond
    attr_reader :id, :type, :term, :yield

    def initialize(id, type, term, y)
      @id = id
      @type = type
      @term = term
      @yield = y
    end

    def ==(other)
      other.class == self.class && other.state == state
    end

    def term_delta(bond)
      (@term - bond.term).abs
    end

    def yield_delta(bond)
      (@yield - bond.yield)
    end

    def state
      instance_variables.map { |v| instance_variable_get(v) }
    end

    def to_csv
      format('%s,%s,%.1f years,%.2f%%', @id, @type, @term, @yield)
    end
  end
end
