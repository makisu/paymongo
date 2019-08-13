require 'spec_helper'

module Paymongo
  RSpec.describe TransactionGateway do
    describe '.sale' do
      context 'with success token' do
        it 'returns a SuccessfulResult',
           { vcr: { record: :once, match_requests_on: %i[method] } } do
          gateway =
            Paymongo::Gateway.new(
              public_key: 'some_public_key',
              secret_key: CONFIG[:secret_key],
              logger: Logger.new('tmp/test.log')
            )
          result =
            gateway.transaction.sale(
              token: 'tok_Ru7gip89uieig4ZcTKa35Ssn',
              amount: 10_000,
              currency: 'PHP',
              description: 'Payment for Invoice #0001',
              statement_descriptor: 'MAKISU.CO'
            )
          expect(result).to be_a(Paymongo::SuccessfulResult)
          tx = result.transaction
          expect(tx.id).to start_with('pay')
          expect(tx.amount).to eq(10_000)
          expect(tx.billing).to be_a(Hash)
          billing = tx.billing
          address = billing[:address]
          expect(address).to be_a(Hash)
          expect(address[:city]).to eq('Furview')
          expect(address[:country]).to eq('PH')
          expect(address[:line1]).to eq('111')
          expect(address[:line2]).to eq('Wanchan St')
          expect(address[:postal_code]).to eq('11111')
          expect(address[:state]).to eq('Metro Manila')
          expect(billing[:email]).to eq('zdoge@doggo.net')
          expect(billing[:name]).to eq('Zooey Doge')
          expect(billing[:phone]).to eq('09171234567')
          expect(tx.created).to be_an(Integer)
          expect(tx.currency).to eq('PHP')
          expect(tx.description).to eq('Payment for Invoice #0001')
          expect(tx.external_reference_number).to be_falsey
          expect(tx.fee).to be_an(Integer)
          expect(tx.livemode).to be(true).or be(false)
          expect(tx.net_amount).to be_an(Integer)
          expect(tx.statement_descriptor).to eq('MAKISU.CO')
          expect(tx.status).to eq('paid')
          expect(tx.updated).to be_an(Integer)
          # TODO: Update tests when adding relationships hash
          # expect(result.relationships.source.id).to start_with('tok')
          # expect(result.relationships.source.type).to eq('token')
        end
      end
      context 'with insufficient_funds token' do
        it 'returns an ErrorResult',
           { vcr: { record: :once, match_requests_on: %i[method] } } do
          gateway =
            Paymongo::Gateway.new(
              public_key: 'some_public_key',
              secret_key: CONFIG[:secret_key],
              logger: Logger.new('tmp/test.log')
            )
          insufficient_funds_token = 'tok_iMMCBQiKHcYmJrE3B5B1FKbS'
          result =
            gateway.transaction.sale(
              token: insufficient_funds_token,
              amount: 20_000,
              currency: 'PHP',
              description: 'Payment for Invoice #0002',
              statement_descriptor: 'MAKISU.CO'
            )
          expect(result).to be_a(Paymongo::ErrorResult)
          error = result.errors[0]
          expect(error[:code]).to eq('insufficient_funds')
          expect(error[:detail]).to eq(
            'Your card has been declined due to insufficient funds.'
          )
          expect(error[:meta][:type]).to eq('card_error')
          expect(error[:status]).to eq('402')
        end
      end
      context 'with generic_decline token' do
        it 'returns an ErrorResult',
           { vcr: { record: :once, match_requests_on: %i[method] } } do
          gateway =
            Paymongo::Gateway.new(
              public_key: 'some_public_key',
              secret_key: CONFIG[:secret_key],
              logger: Logger.new('tmp/test.log')
            )
          generic_decline_token = 'tok_C4EFJehbrrwNCCSrqRL9op5L'
          result =
            gateway.transaction.sale(
              token: generic_decline_token,
              amount: 30_000,
              currency: 'PHP',
              description: 'Payment for Invoice #0003',
              statement_descriptor: 'MAKISU.CO'
            )
          expect(result).to be_a(Paymongo::ErrorResult)
          error = result.errors[0]
          expect(error[:code]).to eq('generic_decline')
          expect(error[:detail]).to eq(
            'Your card has been declined for an unknown reason.'
          )
          expect(error[:meta][:type]).to eq('card_error')
          expect(error[:status]).to eq('402')
        end
      end
    end
  end
end
