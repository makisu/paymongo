require "gem_config"
require "paymongo/version"
require 'net/http'
require 'net/https'
require 'json'
require 'paymongo/gateway'

module Paymongo

  include GemConfig::Base

  with_configuration do
    has :api_key, classes: String
    has :logger
  end

  def self.new(*args)
    Gateway.new(*args)
  end

end
