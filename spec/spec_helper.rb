$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'apple_class_client'

RSpec.configure do |config|
  config.before(:each) do
    AppleClassClient.configure do |client|
      client.private_key = nil
      client.consumer_key = nil
      client.consumer_secret = nil
      client.access_token = nil
      client.access_secret = nil
      client.access_token_expiry = nil
      client.apple_mdm_server = nil
    end
  end
end
