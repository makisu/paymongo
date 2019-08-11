config = YAML.load_file(SPEC_DIR.join('config.yml')).with_indifferent_access
if secret_key = ENV['PAYMONGO-SK-API-KEY'].presence
  config[:secret_key] = secret_key
end
CONFIG = config
