module Overbond
  ##
  # Loads bonds from an input stream.
  #
  class BondFileLoader
    def load(stream)
      header = stream.gets
      validate_header(header)
      results = BondCollection.new
      stream.each_line do |line|
        tokens = line.strip.split(',')
        results << Bond.new(
          tokens[0], tokens[1], parse_term(tokens[2]), parse_yield(tokens[3])
        )
      end
      results
    end

    private

    def validate_header(header)
      raise(OverbondException, 'No header') if header.nil?
      raise(OverbondException, 'Invalid header') if header.strip != valid_header
    end

    def term_regexp
      /^(\d+(\.\d+)?) years$/
    end

    def yield_regexp
      /^(\d+\.\d+)%$/
    end

    def parse_term(term)
      match = term_regexp.match(term)
      raise(OverbondException, "Invalid term \"#{term}\"") if match.nil?
      match[1].to_f
    end

    def parse_yield(y)
      match = yield_regexp.match(y)
      raise(OverbondException, "Invalid yield \"#{y}\"") if match.nil?
      match[1].to_f
    end

    def valid_header
      'bond,type,term,yield'
    end
  end
end
