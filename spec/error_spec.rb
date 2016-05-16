require "spec_helper"

describe AppleClassClient::Error do
  describe ".check_request_error" do
    it "raises an error if the properties match" do
      response = Typhoeus::Response.new(response_code: 400, body: "INVALID_CURSOR")
      expect { AppleClassClient::Error.check_request_error response }.to raise_error AppleClassClient::Error::RequestError, "InvalidCursor"
    end
    it "will check that the response code is 200", focus: true do
      response = Typhoeus::Response.new(response_code: 505, body: "")
      expect { AppleClassClient::Error.check_request_error response }.to raise_error AppleClassClient::Error::RequestError, "GenericError"
    end
    it "can also check for auth errors" do
      response = Typhoeus::Response.new(response_code: 401, body: "")
      expect { AppleClassClient::Error.check_request_error(response, auth: true) }.to raise_error AppleClassClient::Error::RequestError, "Unauthorized"
    end
  end
  describe ".get_errors" do
    it "can return normal errors" do
      errors = AppleClassClient::Error.get_errors
      expect(errors.map { |error| error[0] }).to include "MalformedRequest"
    end
    it "can return auth errors" do
      errors = AppleClassClient::Error.get_errors auth: true
      expect(errors.map { |error| error[0] }).to include "BadRequest"
    end
  end
end
