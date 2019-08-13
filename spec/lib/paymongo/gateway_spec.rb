require 'spec_helper'

module Paymongo
  RSpec.describe Gateway do
    describe '.new' do
      before do
        Paymongo.configure do |c|
          c.secret_key = 'secret_key'
          c.public_key = 'public_key'
        end
      end
      it 'initializes with default config' do
        gateway = described_class.new(Paymongo::Configuration.new)
        expect(gateway).to be_a(Paymongo::Gateway)
      end
      it 'initializes with overriden config' do
        gateway =
          described_class.new(
            public_key: 'some_public_key',
            secret_key: CONFIG[:secret_key],
            logger: Logger.new('tmp/test.log')
          )
        expect(gateway).to be_a(Paymongo::Gateway)
      end
    end
    describe '.transaction' do
      before do
        Paymongo.configure do |c|
          c.secret_key = 'secret_key'
          c.public_key = 'public_key'
        end
      end
      it 'returns a Paymongo::TransactionGateway' do
        gateway = described_class.new(Paymongo::Configuration.new)
        expect(gateway.transaction).to be_a(Paymongo::TransactionGateway)
      end
    end
  end
end
