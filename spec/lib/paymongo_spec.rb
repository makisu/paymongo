require "spec_helper"

RSpec.describe Paymongo do
  describe ".configure" do
    it "allows setting of api_key" do
      Paymongo.configure {|c| c.api_key = "my_api_key"}
      expect(Paymongo.configuration.api_key).
        to eq("my_api_key")
    end

    it "allows setting of logger" do
      logger = Logger.new("tmp/log.log")
      Paymongo.configure {|c| c.logger = logger}
      expect(Paymongo.configuration.logger).to eq(logger)
    end
  end
end
