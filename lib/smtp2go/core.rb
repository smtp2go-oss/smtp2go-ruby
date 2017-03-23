require 'json'
require 'httparty'
require 'smtp2go/exceptions'
require 'smtp2go/settings'

module Smtp2go
  # Ruby Library for interacting with the smtp2go API
  class Smtp2goClient
    # Client to handle API interfacing
    attr_reader :headers, :send_endpoint
    def initialize
      @api_key = ENV['SMTP2GO_API_KEY']
      @headers = HEADERS
      @send_endpoint = SEND_ENDPOINT
      raise Smtp2goAPIKeyException unless @api_key
    end

    # @param sender [String] the from email address
    # @param recipients [Array <String>] the recipient email addresses
    # @param subject [String] the email subject
    # @param body [String] the email body
    # @return [Smtp2goResponse] response object
    def send(sender:, recipients:, subject:, message:)
      payload = {
        api_key: @api_key,
        sender: sender,
        to: recipients,
        subject: subject,
        text_body: message
      }
      response = HTTParty.post(
        @send_endpoint,
        body: JSON.dump(payload),
        headers: @headers
      )
      Smtp2goResponse.new response
    end
  end

  # Wraps response object with smtp2go specific data
  class Smtp2goResponse
    attr_reader :rate_limit
    def initialize(response)
      @response = response
      @rate_limit = RateLimit.new @response.headers
    end

    def json
      JSON.parse @response.body
    end

    def success?
      json['data']['succeeded'] ? true : false
    end

    def errors
      json['data']['error']
    end

    def request_id
      json['request_id']
    end

    def status_code
      @response.code
    end
  end

  # Rate limiting class to be attached to response
  class RateLimit
    attr_reader :limit, :remaining, :reset
    def initialize(headers)
      @limit = headers['x-ratelimit-limit']
      @remaining = headers['x-ratelimit-remaining']
      @reset = headers['x-ratelimit-reset']
    end
  end
end
