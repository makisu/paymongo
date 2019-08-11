module Paymongo
  class Gateway

    attr_accessor :api_key
    attr_accessor :logger

    LOG_TAG = "[paymongo_ruby]"

    def initialize(
      api_key: Paymongo.configuration.api_key,
      logger: Paymongo.configuration.logger
    )
      self.api_key = api_key
      self.logger = logger
    end

    def charge_card(token:, amount:, currency:, description: '', statement_descriptor: '')
      log "Attempting charge with token: #{token}"

      header = {'Content-Type': 'application/json'}
      payment_params = {
        data: {
          attributes: {
            amount: amount,
            currency: currency,
            description: description,
            statement_descriptor: statement_descriptor,
            source: {
              id: token,
              type: "token"
            }
          }
        }
      }.to_json

      uri = URI.parse("https://api.paymongo.com/v1/payments")
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Post.new(uri.path, header)
      req.basic_auth(api_key, '')
      req.body = payment_params
      https.request(req)
    end

    def log(message)
      return if logger.nil?
      logger.info [LOG_TAG, message].join(" ")
    end

  end
end
