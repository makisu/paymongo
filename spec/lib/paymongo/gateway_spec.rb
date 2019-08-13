require 'spec_helper'

module Paymongo
  RSpec.describe Gateway do
    describe '.transaction' do
      it 'returns a Paymongo::TransactionGateway' do
        gateway =
          described_class.new(
            public_key: 'some_public_key',
            secret_key: CONFIG[:secret_key],
            logger: Logger.new('tmp/test.log')
          )
        expect(gateway.transaction).to be_a(Paymongo::TransactionGateway)
      end
    end
  end
end
