module Overbond

  class Bond

    attr_reader :id, :type, :term, :yield

    def initialize( id, type, term, y )
      @id = id
      @type = type
      @term = term
      @yield = y
    end

  end

end

