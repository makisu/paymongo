module Paymongo
  # Super class for all Paymongo exceptions
  class PaymongoError < ::StandardError; end

  class ConfigurationError < PaymongoError; end
end
