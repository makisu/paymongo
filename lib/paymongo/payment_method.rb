module Paymongo
  class PaymentMethod
    include BaseModule

    attr_reader :id
    attr_reader :type
    attr_reader :livemode
    attr_reader :billing
    attr_reader :details
    attr_reader :created_at
    attr_reader :updated_at

    def initialize(gateway, attributes)
      @gateway = gateway
      set_instance_variables_from_hash(attributes[:attributes])
      @id = attributes[:id]
    end
    class << self
      protected :new
      def _new(*args)
        self.new(*args)
      end
    end
  end
end
