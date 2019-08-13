module Paymongo
  class Configuration
    API_VERSION = '1'

    READABLE_ATTRIBUTES = %i[public_key secret_key]

    WRITABLE_ATTRIBUTES = %i[logger public_key secret_key]

    class << self
      attr_writer *WRITABLE_ATTRIBUTES
    end
    attr_reader *READABLE_ATTRIBUTES
    attr_writer *WRITABLE_ATTRIBUTES

    def self.expectant_reader(*attributes)
      attributes.each do |attribute|
        (
          class << self
            self
          end
        )
          .send(:define_method, attribute) do
          attribute_value = instance_variable_get("@#{attribute}")
          if attribute_value.nil? || attribute_value.to_s.empty?
            raise ConfigurationError.new(
                    "Paymongo::Configuration.#{attribute.to_s} needs to be set"
                  )
          end
          attribute_value
        end
      end
    end
    expectant_reader *READABLE_ATTRIBUTES

    def self.gateway
      Paymongo::Gateway.new(instantiate)
    end

    def self.instantiate
      config = new
    end

    def self.logger
      @logger ||= _default_logger
    end

    def initialize(options = {})
      WRITABLE_ATTRIBUTES.each do |attr|
        instance_variable_set "@#{attr}",
                              options[attr] || Paymongo.configuration.send(attr)
      end
    end

    def api_version
      API_VERSION
    end

    def base_url
      "#{protocol}://#{server}:#{port}/v#{API_VERSION}"
    end

    def https
      Http.new(self)
    end

    def logger
      @logger ||= self.class._default_logger
    end

    def port
      443
    end

    def protocol
      'https'
    end

    def server
      'api.paymongo.com'
    end

    def ssl?
      true
    end

    def self._default_logger
      logger = Logger.new(STDOUT)
      logger.level = Logger::INFO
      logger
    end

    def inspect
      super.gsub(/@secret_key=\".*\"/, '@secret_key="[FILTERED]"')
    end

    def assert_has_keys
      if public_key.nil? || secret_key.nil?
        raise ConfigurationError.new(
                'Paymongo::Gateway public_key and secret_key are required.'
              )
      end
    end
  end
end
