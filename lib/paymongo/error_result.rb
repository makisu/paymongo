module Paymongo
  class ErrorResult
    attr_reader :errors

    def initialize(gateway, errors)
      @gateway = gateway
      @errors = errors
    end

    def success?
      false
    end
  end
end
