config = YAML.load_file(SPEC_DIR.join("config.yml")).with_indifferent_access
if api_key = ENV["PAYMONGO_API_KEY"].presence
    config[:api_key] = sender_seed
end
CONFIG = config
