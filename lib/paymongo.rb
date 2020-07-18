require 'gem_config'
require 'paymongo/version'
require 'net/http'
require 'net/https'
require 'json'
require 'paymongo/base_module'
require 'paymongo/gateway'
require 'paymongo/configuration'
require 'paymongo/exceptions'
require 'paymongo/transaction_gateway'
require 'paymongo/transaction'
require 'paymongo/http'
require 'paymongo/successful_result'
require 'paymongo/error_result'
require 'paymongo/payment_method'
require 'paymongo/payment_method_gateway'

module Paymongo
  include GemConfig::Base

  with_configuration do
    has :secret_key, classes: String
    has :public_key, classes: String
    has :logger
  end
end
