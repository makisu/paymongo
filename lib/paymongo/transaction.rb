module Paymongo
  class Transaction
    include BaseModule

    attr_reader :id
    attr_reader :type
    attr_reader :amount
    attr_reader :billing
    attr_reader :created
    attr_reader :currency
    attr_reader :description
    attr_reader :external_reference_number
    attr_reader :fee
    attr_reader :livemode
    attr_reader :net_amount
    attr_reader :statement_descriptor
    attr_reader :status
    attr_reader :updated

    def initialize(gateway, attributes)
      @gateway = gateway
      set_instance_variables_from_hash(attributes[:attributes])
      @id = attributes[:id]
      @type = attributes[:type]
      # TODO: Add relationships hash
    end
    class << self
      protected :new
      def _new(*args)
        self.new(*args)
      end
    end
  end
end
