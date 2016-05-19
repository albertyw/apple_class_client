require "apple_class_client/version"
require "apple_class_client/configuration"

module AppleClassClient
  extend Configuration
end

require "apple_class_client/auth"
require "apple_class_client/error"
require "apple_class_client/request"

require "apple_class_client/class_roster"
