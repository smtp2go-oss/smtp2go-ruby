require "spec_helper"

describe Smtp2go::Smtp2goClient do
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

  it 'has a version number' do
    expect(Smtp2go::VERSION).not_to be nil
  end

  it 'performs a successful send' do
    @smtp2go_client.send
  end

  it 'performs a failed send' do
  end

  it 'fails if the API key environment variable is not set' do
  end

  it 'attaches version headers to requests' do
  end

  it 'attaches content-type to requests' do
  end
end

describe Smtp2go::Smtp2goResponse do
  it 'makes accessible the response JSON' do
  end

  it 'makes accessible the success/failure of the response' do
  end

  it 'makes accessible the request ID on the response' do
  end

  it 'makes accessible the HTTP response code' do
  end

  it 'makes accessible any errors' do
  end

  it 'disallows access to the underlying response object' do
  end

end
