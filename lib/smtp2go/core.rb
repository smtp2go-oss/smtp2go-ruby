require 'smtp2go/exceptions'
require 'smtp2go/settings'

module Smtp2go
  class Smtp2goClient
    def initialize
      @api_key = ENV['SMTP2GO_API_KEY']
      raise SMTP2GoAPIKeyException,
        'SMTP2Go requires SMTP2GO_API_KEY Environment Variable to be set' if not @api_key
    end

    def send
    end
  end

  class Smtp2goResponse
    def initialize response
      @response = response
    end
  end
end
