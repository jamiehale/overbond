module Overbond

  class Bond

    attr_reader :id, :type, :term, :yield

    def initialize( id, type, term, y )
      @id = id
      @type = type
      @term = term
      @yield = y
    end

    def ==( o )
      o.class == self.class && o.state == state
    end

    def term_delta( bond )
      ( @term - bond.term ).abs
    end

    def state
      self.instance_variables.map { |v| self.instance_variable_get v }
    end

    def to_csv
      "%s,%s,%.1f years,%.2f%%" % [ @id, @type, @term, @yield ]
    end

  end

end

