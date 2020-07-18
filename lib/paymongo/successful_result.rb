module Paymongo
  class SuccessfulResult
    attr_reader :transaction
    attr_reader :payment_method

    def initialize(attributes = {})
      @attrs = attributes.keys
      attributes.each { |key, value| instance_variable_set("@#{key}", value) }
    end

    def inspect
      inspected_attributes =
        @attrs.map { |attr| "#{attr}:#{send(attr).inspect}" }
      "#<#{self.class} #{inspected_attributes.join(' ')}>"
    end

    def success?
      true
    end
  end
end
