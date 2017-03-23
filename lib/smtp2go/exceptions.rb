module Smtp2go
  # Exception for when an API key isn't present:
  class Smtp2goAPIKeyException < StandardError
    def message
      'smtp2go requires SMTP2GO_API_KEY Environment Variable to be set'
    end
  end
end
