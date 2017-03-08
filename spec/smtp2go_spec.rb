require "spec_helper"

describe Smtp2go::Smtp2goClient do
  before :all do
    @smtp2go_client = get_client
  end

  subject { @smtp2go_client }
  it { should respond_to :send }

  it 'has a version number' do
    expect(Smtp2go::VERSION).not_to be nil
  end

  it 'performs a successful send' do
    VCR.use_cassette('successful_send') do
      @smtp2go_client.send(PAYLOAD)
    end
  end

  it 'performs a failed send' do
    VCR.use_cassette('failed_send') do
      @smtp2go_client.send(PAYLOAD)
    end
  end

  it 'fails if the API key environment variable is not set' do
    ENV['SMTP2GO_API_KEY'] = nil
    expect(ENV['SMTP2GO_API_KEY']).to be_nil
    expect {Smtp2go::Smtp2goClient.new}.to raise_error(
      Smtp2go::Smtp2goAPIKeyException)
  end

  it 'attaches version headers to requests' do
    expect(HTTParty).to receive(:post).with(
      any_args, hash_including(:headers => Smtp2go::HEADERS))
    @smtp2go_client.send PAYLOAD
  end

  it 'attaches Content-Type to requests' do
    # Check headers contain Content-Type:
    expect(Smtp2go::HEADERS).to include(
      'Content-Type' => Smtp2go::HEADERS['Content-Type'])
    # Check content type is sent in request:
    expect(HTTParty).to receive(:post).with(
      any_args, hash_including(:headers => Smtp2go::HEADERS))
    @smtp2go_client.send PAYLOAD
  end
end

describe Smtp2go::Smtp2goResponse do

  before :all do
    @successful_response = get_successful_response
    @failed_response = get_failed_response
    @response_body = {
      "data"=>
      {
        "failures"=>[],
        "succeeded"=>1,
        "failed"=>0
      },
     "request_id"=>"97134840-02f0-11e7-a1a5-f23c91285f73"
    }
    @error = 'The API Key passed was not in the correct format, Please check'\
    'the key is correct and try again, The full API key can be found in the'\
    'API Keys section in the admin console.'
  end

  subject { @successful_response }
  it { should respond_to :json }
  it { should respond_to :success? }
  it { should respond_to :errors }
  it { should respond_to :request_id }
  it { should respond_to :status_code }
  it { should_not respond_to :response }

  it 'makes accessible the response JSON' do
    expect(@successful_response.json).to eq @response_body
  end

  it 'makes accessible the success/failure of the response' do
    expect(@successful_response.success?).to be true
  end

  it 'makes accessible the request ID on the response' do
    expect(@successful_response.request_id).to eq @response_body['request_id']
  end

  it 'makes accessible the HTTP status code' do
    expect(@successful_response.status_code).to be 200
  end

  it 'makes accessible any errors' do
    # expect(@failed_response.errors).to eq @error.strip!
  end

  it 'disallows access to the underlying response object' do
  end

  it 'returns true for a successful response' do
    expect(@successful_response.success?).to be true
  end

  it 'returns false for a failed response' do
    expect(@failed_response.success?).to be false
  end
end
