# Methods for getting and setting class roster details

module AppleClassClient
  module ClassRoster
    FETCH_PATH = "/roster/class"
    def self.fetch
      AppleClassClient::Request.make_request(AppleClassClient::Request.make_url(FETCH_PATH), :post, "")
    end
  end
end
