require 'spec_helper'

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
      response = @smtp2go_client.send(PAYLOAD)
      expect(response.success?).to be true
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
    expect { Smtp2go::Smtp2goClient.new }.to raise_error(
      Smtp2go::Smtp2goAPIKeyException
    )
  end

  it 'attaches version headers to requests' do
    expect(HTTParty).to receive(:post).with(
      any_args, hash_including(headers: Smtp2go::HEADERS)
    ).and_return get_response_object
    VCR.use_cassette('successful_send') do
      @smtp2go_client.send(PAYLOAD)
    end
  end

  it 'attaches Content-Type to requests' do
    # Check headers contain Content-Type:
    expect(Smtp2go::HEADERS).to include(
      'Content-Type' => Smtp2go::HEADERS['Content-Type']
    )
    expect(HTTParty).to receive(:post).with(
      any_args, hash_including(headers: Smtp2go::HEADERS)
    ).and_return get_response_object
    VCR.use_cassette('successful_send') do
      @smtp2go_client.send(PAYLOAD)
    end
  end

  it 'raises exception if not provided either html or text in the call to send' do
    VCR.use_cassette('successful_send') do
      payload = PAYLOAD.clone
      payload[:html] = nil
      payload[:text] = nil
      expect { @smtp2go_client.send(payload) }.to raise_error(
        Smtp2go::Smtp2goParameterException
      )
    end
  end

  it 'sends an email if html is not passed to send' do
    VCR.use_cassette('successful_send') do
      payload = PAYLOAD.clone
      payload[:html] = nil
      expect(payload[:html]).to be_nil
      response = @smtp2go_client.send(PAYLOAD)
      expect(response.success?).to be true
    end
  end

  it 'sends an email if text is not passed to send' do
    VCR.use_cassette('successful_send') do
      payload = PAYLOAD.clone
      payload[:text] = nil
      expect(payload[:text]).to be_nil
      response = @smtp2go_client.send(PAYLOAD)
      expect(response.success?).to be true
    end
  end
end

