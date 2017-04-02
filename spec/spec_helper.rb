# Before all other requirements:
require 'coveralls'
Coveralls.wear!

$LOAD_PATH.unshift File.expand_path('../../lib', __FILE__)
require 'smtp2go'
require 'vcr'
require 'webmock/rspec'

Coveralls.wear!

# Configure VCR to mock responses:
VCR.configure do |c|
  c.cassette_library_dir = 'spec/cassettes'
  c.hook_into :webmock
  c.configure_rspec_metadata!
end

# Constants:
PAYLOAD = {
  sender: 'dave@example.com',
  recipients: ['matt@example.com'],
  subject: 'smtp2go Ruby Client',
  text: 'Test message.',
  html: '<html><body><p>Test Message</p></body></html>'
}

# Helper methods:
def get_response_object
  # Gets HTTParty response object
  VCR.use_cassette('successful_send') do
    HTTParty.post(Smtp2go::SEND_ENDPOINT, PAYLOAD)
  end
end

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
