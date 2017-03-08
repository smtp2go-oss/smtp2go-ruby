$LOAD_PATH.unshift File.expand_path("../../lib", __FILE__)
require 'smtp2go'
require 'vcr'
require 'webmock/rspec'

# Configure VCR to mock responses:
VCR.configure do |c|
    c.cassette_library_dir = 'spec/cassettes'
    c.hook_into :webmock
    c.configure_rspec_metadata!
end

# Constants:
PAYLOAD = {
  :sender => 'dave@example.com',
  :recipients => ['matt@example.com'],
  :subject => 'smtp2go Ruby Client',
  :message => 'Test message.'
}

# Helper methods: 
def get_client
  ENV['SMTP2GO_API_KEY'] = 'testapikey'
  Smtp2go::Smtp2goClient.new
end

def get_successful_response
  smtp2go_client = get_client
  VCR.use_cassette('successful_send') do
    smtp2go_client.send(PAYLOAD)
  end
end

def get_failed_response
  smtp2go_client = get_client
  VCR.use_cassette('failed_send') do
    smtp2go_client.send(PAYLOAD)
  end
end
