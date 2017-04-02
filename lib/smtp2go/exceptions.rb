module Smtp2go
  class Smtp2goBaseException < StandardError
  end

  class Smtp2goAPIKeyException < Smtp2goBaseException
    def message
      'Smtp2go requires SMTP2GO_API_KEY Environment Variable to be set'
    end
  end

  class Smtp2goParameterException < Smtp2goBaseException
    def message
      'send call requires either text or html arguments'
    end
  end
end
