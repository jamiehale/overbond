module Overbond
  ##
  # A collection of bonds that behaves like a queryable array.
  #
  class BondCollection
    def initialize
      @bonds = []
    end

    def empty?
      @bonds.empty?
    end

    def count
      @bonds.count
    end

    def <<(bond)
      @bonds << bond
    end

    def [](index)
      @bonds[index]
    end

    def each(type, &blk)
      all(type).each(&blk)
    end

    def all(type)
      @bonds.select { |b| b.type == type }
    end
  end
end
