require 'gem_config'
require 'paymongo/version'
require 'net/http'
require 'net/https'
require 'json'
require 'paymongo/gateway'

module Paymongo
  include GemConfig::Base

  with_configuration do
    has :secret_key, classes: String
    has :public_key, classes: String
    has :logger
  end
end
