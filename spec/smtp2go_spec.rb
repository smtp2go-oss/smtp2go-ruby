require "spec_helper"

describe Smtp2go::Smtp2goClient do

  before :each do
    ENV['SMTP2GO_API_KEY'] = 'testapikey'
    @smtp2go_client = Smtp2go::Smtp2goClient.new
    allow(@smtp2go_client).to receive(:send).and_return(fake_response)
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
    @smtp2go_client.send @payload
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



class MockResponseObject
  def initialize
    @code = 200
    @data = {
      "data"=> {
        "failures"=>[],
        "succeeded"=>1,
        "failed"=>0
      },
      "request_id"=>"4143a82e-0214-11e7-b3d0-f23c91285f72"
    }
  end
end

describe Smtp2go::Smtp2goResponse do

  before :each do
    @smtp2go_response = nil
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
