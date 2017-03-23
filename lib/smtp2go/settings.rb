require 'smtp2go/version'

module Smtp2go
  API_ROOT = 'https://api.smtp2go.com/v3/'.freeze
  API_SEND_URL = 'email/send'.freeze
  SEND_ENDPOINT = API_ROOT + API_SEND_URL
  HEADERS = {
    'Content-Type' => 'application/json',
    'X-Smtp2go-Api' => 'smtp2go-ruby',
    'X-Smtp2go-Api-Version' => VERSION
  }.freeze
end
