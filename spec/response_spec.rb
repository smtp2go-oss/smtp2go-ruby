require 'spec_helper'

describe Smtp2go::Smtp2goResponse do
  before :all do
    @successful_response = get_successful_response
    @failed_response = get_failed_response
    @response_body = {
      'data' =>
        {
          'failures' => [],
          'succeeded' => 1,
          'failed' => 0
        },
      'request_id' => '97134840-02f0-11e7-a1a5-f23c91285f73'
    }
    @error = 'The API Key passed was not in the correct format, Please check '\
    'the key is correct and try again, The full API key can be found in the '\
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
    expect(@failed_response.errors).to eq @error
  end

  it 'returns true for a successful response' do
    expect(@successful_response.success?).to be true
  end

  it 'returns false for a failed response' do
    expect(@failed_response.success?).to be false
  end
end

describe Smtp2go::RateLimit do
  before :all do
    @response = get_response_object
    @rate_limit = Smtp2go::RateLimit.new @response.headers
  end

  it 'returns the rate limit' do
    expect(@rate_limit.limit).to eq @response.headers['x-ratelimit-limit']
  end

  it 'returns the remaining rate limit' do
    expect(@rate_limit.remaining).to eq(
      @response.headers['x-ratelimit-remaining']
    )
  end

  it 'returns the rate limit reset' do
    expect(@rate_limit.reset).to eq @response.headers['x-ratelimit-reset']
  end

  it 'returns the rate limiting information when attached to Smtp2goResponse' do
    response = Smtp2go::Smtp2goResponse.new @response
    expect(response.rate_limit.limit).to eq(
      @response.headers['x-ratelimit-limit']
    )
    expect(response.rate_limit.remaining).to eq(
      @response.headers['x-ratelimit-remaining']
    )
    expect(response.rate_limit.reset).to eq(
      @response.headers['x-ratelimit-reset']
    )
  end
end
