require 'JSON'
require 'httparty'
require 'smtp2go/exceptions'
require 'smtp2go/settings'

module Smtp2go
  class Smtp2goClient
    def initialize
      @api_key = ENV['SMTP2GO_API_KEY']
      raise SMTP2GoAPIKeyException,
        'SMTP2Go requires SMTP2GO_API_KEY Environment Variable to be set' if not @api_key
    end

    def send(sender:, recipients:, subject:, message:)
      payload = {
        'api_key' => @api_key,
        'sender' => sender,
        'to' => recipients,
        'subject' => subject,
        'text_body' => message,
      }
    end
  end

  class Smtp2goResponse
    def initialize response
      @response = response
    end

    def json
      @response.parsed_response
    end

    def success?
      self.json['data']['succeeded'] ? true : false
    end

    def errors
      self.json['data']['errors']
    end

    def request_id
      self.json['request_id']
    end

    def response_code
      @response.code
    end

  end
end
