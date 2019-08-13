module Paymongo
  module BaseModule
    module Methods
      def set_instance_variables_from_hash(hash)
        hash.each { |key, value| instance_variable_set "@#{key}", value }
      end
    end
    def self.included(klass)
      klass.extend Methods
    end
    include Methods
  end
end
