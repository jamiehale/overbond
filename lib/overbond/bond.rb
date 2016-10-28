module Overbond

  class Bond

    attr_reader :id, :type, :term, :yield

    def initialize( id, type, term, y )
      @id = id
      @type = type
      @term = term
      @yield = y
    end

    def term_delta( bond )
      ( @term - bond.term ).abs
    end

  end

end

