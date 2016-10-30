module Overbond

  class BondFileLoader

    def load( stream )
      header = stream.gets
      raise OverbondException.new( 'No header' ) if header.nil?
      raise OverbondException.new( 'Invalid header' ) if header.strip != 'bond,type,term,yield'
      results = BondCollection.new()
      stream.each_line do |line|
        tokens = line.strip.split( ',' )
        results << Bond.new( tokens[ 0 ], tokens[ 1 ], parse_term( tokens[ 2 ] ), parse_yield( tokens[ 3 ] ) )
      end
      results
    end

    private

        def term_regexp
          /^(\d+(\.\d+)?) years$/
        end

        def yield_regexp
          /^(\d+\.\d+)%$/
        end

        def parse_term( term )
          match = term_regexp.match( term )
          raise OverbondException.new( "Invalid term \"#{term}\"" ) if match.nil?
          return match[ 1 ].to_f
        end

        def parse_yield( y )
          match = yield_regexp.match( y )
          raise OverbondException.new( "Invalid yield \"#{y}\"" ) if match.nil?
          return match[ 1 ].to_f
        end

  end

end

