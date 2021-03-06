# This contains a few hacks that adds support for non-ancient versions of Typhoeus to
# the ancient dead ruby oauth gem

require "oauth/request_proxy/base"
require "typhoeus"
require "typhoeus/request"
require "uri"
require "cgi"

module OAuth::RequestProxy::Typhoeus
  class Request < OAuth::RequestProxy::Base
    # Proxy for signing Typhoeus::Request requests
    # Usage example:
    # oauth_params = {:consumer => oauth_consumer, :token => access_token}
    # req = Typhoeus::Request.new(uri, options)
    # oauth_helper = OAuth::Client::Helper.new(req, oauth_params.merge(:request_uri => uri))
    # req.headers.merge!({"Authorization" => oauth_helper.header})
    # hydra = Typhoeus::Hydra.new()
    # hydra.queue(req)
    # hydra.run
    # response = req.response
    proxies Typhoeus::Request

    def method
      request_method = request.options[:method].to_s.upcase
      request_method.empty? ? "GET" : request_method
    end

    def uri
      options[:uri].to_s
    end

    def parameters
      if options[:clobber_request]
        options[:parameters]
      else
        post_parameters.merge(query_parameters).merge(options[:parameters] || {})
      end
    end

    private

    def query_parameters
      query = URI.parse(request.url).query
      query ? CGI.parse(query) : {}
    end

    def post_parameters
      # Post params are only used if posting form data
      if method == "POST"
        OAuth::Helper.stringify_keys(request.params || {})
      else
        {}
      end
    end
  end
end
