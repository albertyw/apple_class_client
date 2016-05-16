# Errors for AppleClassClient and Apple's endpoints

require 'typhoeus'

module AppleClassClient
  module Error
    AUTH_ERRORS = [
      # Used by AppleClassClient::Auth
      ["BadRequest",          400, ""],
      ["Unauthorized",        401, ""],
      ["Forbidden",           403, ""],
    ]

    ERRORS = [
      # Server failures
      ["InternalServerError", 500, ""],
      ["ServiceUnavailable",  503, ""],

      # Client errors
      ["Unauthorized",        401, "UNAUTHORIZED"],
      ["Forbidden",           403, "FORBIDDEN"],
      ["MalformedRequest",    400, "MALFORMED_REQUEST_BODY"],
      ["CursorRequired",      400, "CURSOR_REQUIRED"],
      ["InvalidCursor",       400, "INVALID_CURSOR"],
      ["ExpiredCursor",       400, "EXPIRED_CURSOR"],
      ["TooManyRequests",     429, "TOO_MANY_REQUESTS"],
    ]

    def self.check_request_error(response, auth:false)
      get_errors(auth: auth).each do |error_name, response_code, body|
        if response.code == response_code && response.body.include?(body)
          raise RequestError, error_name
        end
      end
      if response.code != 200
        raise RequestError, "GenericError"
      end
    end

    def self.get_errors(auth:false)
      auth ? AUTH_ERRORS : ERRORS
    end

    class RequestError < RuntimeError
    end
  end
end
