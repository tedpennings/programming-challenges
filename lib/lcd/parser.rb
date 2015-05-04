module Lcd

  # Parses the user-input per the rules specified in the Lcd module.
  class Parser
    attr_reader :size, :number
    def initialize(size, number)
      @size = size
      @number = number
      validate_inputs
    end

    def validate_inputs
      raise ArgumentError, "Invalid size! Received #{size}" unless (1...10).include? size
      raise ArgumentError, "Invalid number! Received #{number}" unless (0...99_999_999).include? number
    end

    def self.parse(input_string)
      if input_string =~ /^(?<size>\d+)\s+(?<number>\d+)\s*$/
        new($~[:size].to_i, $~[:number].to_i)
      else
        raise ArgumentError, "Unable to parse #{input_string}! expected an input in the format '4 492'"
      end
    end

    def to_display
      Display.new(size, number)
    end
  end
end
