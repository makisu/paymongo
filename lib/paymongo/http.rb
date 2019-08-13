module Paymongo
  class Http
    def initialize(config)
      @config = config
    end

    def post(path, params = nil)
      header = { 'Content-Type': 'application/json' }
      uri = URI.parse(path)
      https = Net::HTTP.new(uri.host, uri.port)
      https.use_ssl = true
      req = Net::HTTP::Post.new(uri.path, header)
      # TODO: Put password in basic_auth as part of config
      req.basic_auth(@config.secret_key, '')
      req.body = params[:transaction].to_json
      res = https.request(req)
      JSON.parse(res.body).with_indifferent_access
    end
  end
end
