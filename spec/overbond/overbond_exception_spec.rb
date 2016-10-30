require 'spec_helper'

module Overbond

  describe OverbondException do

    it 'exists' do
      expect{ OverbondException.new() }.not_to raise_error
    end

  end

end
