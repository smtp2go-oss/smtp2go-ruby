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

  subject { @smtp2go_client }
  it { should respond_to :send }

  it 'has a version number' do
    expect(Smtp2go::VERSION).not_to be nil
  end

  it 'performs a successful send' do
    VCR.use_cassette('successful_send') do
      @smtp2go_client.send(@payload)
    end
  end

  # it 'performs a failed send' do
  #   VCR.use_cassette('failed_send') do
  #     @smtp2go_client.send(@payload)
  #   end
  # end

  # it 'fails if the API key environment variable is not set' do
  #   ENV['SMTP2GO_API_KEY'] = nil
  #   expect(ENV['SMTP2GO_API_KEY']).to be_nil
  #   expect {Smtp2go::Smtp2goClient.new}.to raise_error(
  #     Smtp2goAPIKeyException)  # TODO: Refactor
  # end

  # it 'attaches version headers to requests' do
  #   response = @smtp2go_client.send(@payload)
  #   headers = @smtp2go_client.headers
  #   expect(headers.keys).to include(
  #     'X-Smtp2go-Api', 'X-Smtp2go-Api-Version', 'Content-Type')
  #   expect(headers.values).to include(
  #     'smtp2go-ruby', Smtp2go::VERSION, 'application/json')
  #   expect(a_request(:any, @smtp2go_client.send_endpoint).with {
  #     |req| req.headers == @headers })
  # end

  it 'attaches content-type to requests' do
  end
end

describe Smtp2go::Smtp2goResponse do

  before :each do
    # ENV['SMTP2GO_API_KEY'] = 'testapikey'
    # @smtp2go_client = Smtp2go::Smtp2goClient.new
    # @payload = {
    #   :sender => 'dave@example.com',
    #   :recipients => ['matt@example.com'],
    #   :subject => 'smtp2go Ruby Client',
    #   :message => 'Test message.'
    # }
    # @smtp2go_response = @smtp2go_client.send @payload
  end

  subject { @smtp2go_response }
  # it { should respond_to :json }
  # it { should respond_to :success? }
  # it { should respond_to :errors }
  # it { should respond_to :request_id }
  # it { should respond_to :response_code }
  it { should_not respond_to :response }

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
