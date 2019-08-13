module Paymongo
  class Gateway
    attr_reader :config

    def initialize(config)
      if config.is_a?(Hash)
        @config = Configuration.new config
      elsif config.is_a?(Paymongo::Configuration)
        @config = config
      else
        raise ArgumentError, 'config is an invalid type'
      end
    end

    def charge_card(
      token:, amount:, currency:, description: '', statement_descriptor: ''
    )
      header = { 'Content-Type': 'application/json' }
      payment_params = {
        data: {
          attributes: {
            amount: amount,
            currency: currency,
            description: description,
            statement_descriptor: statement_descriptor,
            source: { id: token, type: 'token' }
          }
        }
      }.to_json

      uri = URI.parse('https://api.paymongo.com/v1/payments')
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Post.new(uri.path, header)
      req.basic_auth(config.secret_key, '')
      req.body = payment_params
      https.request(req)
    end

    def transaction
      TransactionGateway.new(self)
    end
  end
end
