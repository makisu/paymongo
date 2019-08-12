require 'spec_helper'

module Paymongo
  RSpec.describe Gateway do
    it(
      'charges the card given a token',
      { vcr: { record: :once, match_requests_on: %i[method] } }
    ) do
      gateway =
        described_class.new(
          secret_key: CONFIG[:secret_key],
          logger: Logger.new('tmp/test.log')
        )
      res =
        gateway.charge_card(
          token: 'tok_Ru7gip89uieig4ZcTKa35Ssn',
          amount: 10_000,
          currency: 'PHP',
          description: 'Payment for Invoice #0001',
          statement_descriptor: 'MAKISU.CO'
        )
      expect(res.code).to eq('201')
    end
  end
end
