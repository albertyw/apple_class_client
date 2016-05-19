require "spec_helper"

describe AppleClassClient::ClassRoster do
  it "can fetch data" do
    url = AppleClassClient::Request.make_url(AppleClassClient::ClassRoster::FETCH_PATH)
    expect(AppleClassClient::Request).to receive(:make_request).with(url, :post, "").and_return("asdf").once
    expect(AppleClassClient::ClassRoster.fetch).to eq "asdf"
  end
end
