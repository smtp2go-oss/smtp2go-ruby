require "spec_helper"

describe Smtp2go do
  before :each do
    ENV['SMTP2GO_API_KEY'] = 'testapikey'
    @smtp2go_client = Smtp2go::Smtp2goClient.new
    @payload = {
      :sender => 'dave@example.com',
      :recipients => ['matt@example.com'],
      :subject => 'smtp2go Ruby Client',
      :message => 'Test message.'
    }
  end

  it "has a version number" do
    expect(Smtp2go::VERSION).not_to be nil
  end

  it "performs a successful send" do
    @smtp2go_client.send
  end
end
