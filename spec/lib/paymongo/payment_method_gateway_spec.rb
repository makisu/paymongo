require 'spec_helper'

module Paymongo
  RSpec.describe PaymentMethodGateway do
    describe '.get' do
      context 'with valid payment method id' do
        it 'returns a SuccessfulResult', vcr: { record: :once, match_requests_on: %i[method] } do
          gateway =
            Paymongo::Gateway.new(
              public_key: 'some_public_key',
              secret_key: CONFIG[:secret_key],
              logger: Logger.new('tmp/test.log')
            )
          result = gateway.payment_method.get('pm_sVDMnem4gYcxTtAnpGZHFXi2')
          expect(result).to be_a(Paymongo::SuccessfulResult)
          payment_method = result.payment_method
          expect(payment_method.id).to eq('pm_sVDMnem4gYcxTtAnpGZHFXi2')
          expect(payment_method.type).to eq('card')
          billing = payment_method.billing
          expect(billing).to be_a(Hash)
          expect(billing[:address][:city]).to eq('Taguig')
          expect(billing[:address][:country]).to eq('PH')
          expect(billing[:address][:line1]).to eq('Unit 3308, High St South Corp Plaza')
          expect(billing[:address][:line2]).to eq('26th Street & 11th Avenue')
          expect(billing[:address][:postal_code]).to eq('1634')
          expect(billing[:address][:state]).to eq('Metro Manila')
          expect(billing[:email]).to eq('juan@paymongo.com')
          expect(billing[:name]).to eq('Juan Dela Cruz')
          expect(billing[:phone]).to eq('63288881111')
          expect(payment_method.created_at).to be_an(Integer)
          expect(payment_method.updated_at).to be_an(Integer)
          details = payment_method.details
          expect(details[:exp_month]).to eq(1)
          expect(details[:exp_year]).to eq(24)
          expect(details[:last4]).to eq('4345')
          expect(payment_method.livemode).to eq(false)
        end
      end
      context 'invalid payment method id' do
        it 'returns an ErrorResult', vcr: { record: :once, match_requests_on: %i[method] } do
          gateway =
            Paymongo::Gateway.new(
              public_key: 'some_public_key',
              secret_key: CONFIG[:secret_key],
              logger: Logger.new('tmp/test.log')
            )
          id = 'invalid_payment_method_id'
          result = gateway.payment_method.get(id)
          expect(result).to be_a(Paymongo::ErrorResult)
          error = result.errors[0]
          expect(error[:code]).to eq('resource_not_found')
          expect(error[:detail]).to eq("No such payment method with id #{id}.")
        end
      end
    end
    describe '.create' do
      context 'with valid details' do
        it 'returns a SuccessfulResult', vcr: { record: :once, match_requests_on: %i[method] } do
          gateway =
            Paymongo::Gateway.new(
              public_key: 'some_public_key',
              secret_key: CONFIG[:secret_key],
              logger: Logger.new('tmp/test.log')
            )
          result =
            gateway.payment_method.create(
              line1: 'Unit 3308, High St South Corp Plaza',
              line2: '26th Street & 11th Avenue',
              city: 'Taguig',
              state: 'Metro Manila',
              postal_code: '1634',
              country: 'PH',
              email: 'juan@paymongo.com',
              name: 'Juan Dela Cruz',
              phone: '63288881111',
              card_number: '4343434343434345',
              exp_month: 1,
              exp_year: 24,
              cvc: '999',
              type: 'card',
              metadata: {
                sample: '123'
              }
            )
          expect(result).to be_a(Paymongo::SuccessfulResult)
          payment_method = result.payment_method
          expect(payment_method.id).to eq('pm_sVDMnem4gYcxTtAnpGZHFXi2')
          expect(payment_method.type).to eq('card')
          billing = payment_method.billing
          expect(billing).to be_a(Hash)
          expect(billing[:address][:city]).to eq('Taguig')
          expect(billing[:address][:country]).to eq('PH')
          expect(billing[:address][:line1]).to eq('Unit 3308, High St South Corp Plaza')
          expect(billing[:address][:line2]).to eq('26th Street & 11th Avenue')
          expect(billing[:address][:postal_code]).to eq('1634')
          expect(billing[:address][:state]).to eq('Metro Manila')
          expect(billing[:email]).to eq('juan@paymongo.com')
          expect(billing[:name]).to eq('Juan Dela Cruz')
          expect(billing[:phone]).to eq('63288881111')
          expect(payment_method.created_at).to be_an(Integer)
          expect(payment_method.updated_at).to be_an(Integer)
          details = payment_method.details
          expect(details[:exp_month]).to eq(1)
          expect(details[:exp_year]).to eq(24)
          expect(details[:last4]).to eq('4345')
          expect(payment_method.livemode).to eq(false)
        end
      end
      context 'with missing cvc', vcr: { record: :once, match_requests_on: %i[method] } do
        it 'returns an ErrorResult' do
          gateway =
            Paymongo::Gateway.new(
              public_key: 'some_public_key',
              secret_key: CONFIG[:secret_key],
              logger: Logger.new('tmp/test.log')
            )
          result =
            gateway.payment_method.create(
              line1: 'Unit 3308, High St South Corp Plaza',
              line2: '26th Street & 11th Avenue',
              city: 'Taguig',
              state: 'Metro Manila',
              postal_code: '1634',
              country: 'PH',
              email: 'juan@paymongo.com',
              name: 'Juan Dela Cruz',
              phone: '63288881111',
              card_number: '4343434343434345',
              exp_month: 1,
              exp_year: 24,
              type: 'card',
              metadata: {
                sample: '123'
              }
            )
          expect(result).to be_a(Paymongo::ErrorResult)
        end
      end
    end
  end
end
