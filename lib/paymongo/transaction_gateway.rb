module Paymongo
  class TransactionGateway
    def initialize(gateway)
      @gateway = gateway
      @config = gateway.config
      @config.assert_has_keys
    end

    def sale(attributes)
      # Wrap the hash
      create(
        {
          data: {
            attributes: {
              amount: attributes[:amount],
              currency: attributes[:currency],
              description: attributes[:description],
              statement_descriptor: attributes[:statement_descriptor],
              source: { id: attributes[:token], type: 'token' }
            }
          }
        }
      )
    end

    def create(attributes)
      _do_create '/payments', transaction: attributes
    end

    def _do_create(path, params = nil)
      response = @config.https.post("#{@config.base_url}#{path}", params)
      _handle_transaction_response(response)
    end

    def _handle_transaction_response(response)
      if response[:data]
        SuccessfulResult.new(
          transaction: Transaction._new(@gateway, response[:data])
        )
      elsif response[:errors]
        ErrorResult.new(@gateway, response[:errors])
      else
        raise UnexpectedError, 'expected :data'
      end
    end
  end
end
