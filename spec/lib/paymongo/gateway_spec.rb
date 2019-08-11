require "spec_helper"

module Paymongo
  RSpec.describe Gateway do
    it("charges the card given a token", {
      vcr: {record: :once, match_requests_on: [:method]}
    }) do
      gateway = described_class.new(
        api_key: CONFIG[:api_key],
        logger: Logger.new("tmp/test.log")
      )
      res = gateway.charge_card(
        token: "tok_UHjwSWUYYMo3vyXMKBGjf6bR",
        amount: 10000,
        currency: "PHP",
        description: "Payment for Invoice #0001",
        statement_descriptor: "MAKISU.CO"
      )
      expect(res.code).to eq("201")
    end
  end
end
