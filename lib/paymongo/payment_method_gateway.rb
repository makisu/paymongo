module Paymongo
  class PaymentMethodGateway

    RESOURCE_NAME = 'payment_methods'.freeze

    def initialize(gateway)
      @gateway = gateway
      @config = gateway.config
      @config.assert_has_keys
    end

    # Retrieves a PaymentMethod
    #
    # @param id [String] id of PaymentMethod to retrieve
    def get(id)
      response = @config.https.get("#{base_url}/#{id}")
      _handle_transaction_response(response)
    end

    # Creates a PaymentMethod
    #
    # @param attributes [Hash]
    def create(attributes)
      attributes = { data: {
        attributes: {
          billing: {
            address: {
              line1: attributes[:line1],
              line2: attributes[:line2],
              city: attributes[:city],
              state: attributes[:state],
              postal_code: attributes[:postal_code],
              country: attributes[:country]
            },
            email: attributes[:email],
            name: attributes[:name],
            phone: attributes[:phone]
          },
          details: {
            card_number: attributes[:card_number],
            exp_month: attributes[:exp_month],
            exp_year: attributes[:exp_year],
            cvc: attributes[:cvc]
          },
          type: attributes[:type],
          metadata: attributes[:metadata]
        }
      }}
      _do_create body: attributes
    end

    def _do_create(params = nil)
      response = @config.https.post(base_url, params)
      _handle_transaction_response(response)
    end

    def _handle_transaction_response(response)
      if response[:data]
        SuccessfulResult.new(
          payment_method: PaymentMethod._new(@gateway, response[:data])
        )
      elsif response[:errors]
        ErrorResult.new(@gateway, response[:errors])
      else
        raise UnexpectedError, 'expected :data'
      end
    end

    private

    def base_url
      "#{@config.base_url}/#{RESOURCE_NAME}"
    end
  end
end
