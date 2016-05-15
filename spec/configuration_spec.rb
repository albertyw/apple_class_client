require "spec_helper"

describe "AppleClassClient::Configuration" do
  it "has a default apple_mdm_server value" do
    expect(AppleClassClient::Configuration::CONFIG[:apple_mdm_server]).to_not be_nil
  end

  it "can be configured" do
    AppleClassClient.private_key = "asdf"
    AppleClassClient.consumer_key = "qwer"
    expect(AppleClassClient.private_key).to eq "asdf"
    expect(AppleClassClient.consumer_key).to eq "qwer"
  end

  describe ".method_missing" do
    it "can get value for valid configuration keys" do
      expect(AppleClassClient).to receive(:get_value).with(:access_token).and_return "asdf"
      expect(AppleClassClient.access_token).to eq "asdf"
    end
    it "can raise NoMethodError for invalid configuration keys" do
      expect { AppleClassClient.asdf }.to raise_error NoMethodError
    end
  end

  describe ".get_value" do
    it "can get a configuration value directly from the saved value" do
      AppleClassClient.private_key = "qwer"
      expect(AppleClassClient.private_key).to eq "qwer"
    end
    it "will get the default value if the instance variable isn't set" do
      expect(AppleClassClient.apple_mdm_server).to_not be_nil
    end
    it "can get a configuration value by calling a Proc" do
      AppleClassClient.private_key = lambda { return "qwer" }
      expect(AppleClassClient.private_key).to eq "qwer"
    end
  end

  describe ".get_default_value" do
    it "will read the default value from CONFIG" do
      apple_mdm_server = AppleClassClient::Configuration::CONFIG[:apple_mdm_server]
      expect(AppleClassClient.get_default_value("apple_mdm_server")).to eq apple_mdm_server
    end
  end

  describe ".configure" do
    it "can be configured in a block" do
      AppleClassClient.configure do |x|
        x.private_key = "asdf"
      end
      expect(AppleClassClient.private_key).to eq "asdf"
    end
  end
end
