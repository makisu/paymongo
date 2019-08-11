require "spec_helper"

RSpec.describe Paymongo do
  describe ".configure" do
    it "allows setting of secret_key" do
      Paymongo.configure {|c| c.secret_key = "my_api_key"}
      expect(Paymongo.configuration.secret_key).
        to eq("my_api_key")
    end

    it "allows setting of public_key" do
      Paymongo.configure {|c| c.public_key = "p_key"}
      expect(Paymongo.configuration.public_key).
        to eq("p_key")
    end

    it "allows setting of logger" do
      logger = Logger.new("tmp/log.log")
      Paymongo.configure {|c| c.logger = logger}
      expect(Paymongo.configuration.logger).to eq(logger)
    end
  end
end
