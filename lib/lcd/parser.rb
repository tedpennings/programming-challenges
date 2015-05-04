module Lcd
  class Parser

    # Parses the user-input per the rules specified in the Lcd module.
    PARSER_REGEX = /^(?<size>\d+)\s+(?<number>\d+)\s*$/

    def self.parse(input_string)
      if match = PARSER_REGEX.match(input_string)
        Display.new(match[:size].to_i, match[:number].to_i)
      else
        raise ArgumentError, "Unable to parse #{input_string}! expected an input in the format '4 492'"
      end
    end

  end
end
