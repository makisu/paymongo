require "bundler/setup"
require "paymongo"
require "active_support/core_ext/hash/indifferent_access"
require "active_support/core_ext/object/blank"
require "yaml"
require "pathname"
require "pry-byebug"
require "logger"

SPEC_DIR = Pathname.new(File.dirname(__FILE__))
TMP_DIR = SPEC_DIR.join("../tmp")

Dir[SPEC_DIR.join("support", "**", "*.rb")].each {|f| require f}

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.before :suite do
    FileUtils.mkdir_p TMP_DIR
  end
end
