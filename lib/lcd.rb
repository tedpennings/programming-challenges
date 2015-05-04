require 'active_support/core_ext/string'

module Lcd

  def self.print_from_text(text)
    lines = String(text).lines.map(&:strip).reject(&:blank?)
    terminator = lines.pop
    unless terminator =~ /0\s+0/
      # this responsibility could live in the parser...
      raise ArgumentError, "Unexpected format! Expected '0 0' terminator"
    end
    lines.each do |display_line|
      Parser.parse(display_line).to_display.print
    end
  end

  class Display
    HYPHEN = '-'.freeze
    PIPE   = '|'.freeze
    SPACE  = ' '.freeze

    attr_reader :size, :number
    def initialize(size, number)
      @size = size
      @number = number
    end

    def print
      output = ''
      digit_series = number.to_s.chars.map { |digit| send :"make#{digit}" }
      total_row_count = (2 * size) + 2
      puts "digit_series.length #{digit_series.length}"
      puts "digit_series.map(&:length) #{digit_series.map(&:length)}"
      (0..total_row_count).each do |row_number|
        output << extract_combined_row(row_number, digit_series)
      end
      puts output
    end

    def extract_combined_row(row_num, digit_series)
      digit_series.map { digit_series[row_num] }.join(SPACE) + "\n"
    end

    private

    def make1
      result = [] << empty_line
      2.times do # NOT size.times
        result.push ([SPACE * (size + 1) + PIPE] * size)
        result << empty_line
      end
      result
    end

    def make2
      result = []
      result << (SPACE + (HYPHEN * size) + SPACE)
      size.times do
        result << ((SPACE * (size + 1)) + PIPE)
      end
      result << (SPACE + (HYPHEN * size) + SPACE)
      size.times do
        result << (PIPE + (SPACE * (size + 1)))
      end
      result << (SPACE + (HYPHEN * size) + SPACE)
      result
    end

    def make3
      result = []
      result << (SPACE + (HYPHEN * size) + SPACE)
      size.times do
        result << ((SPACE * (size + 1)) + PIPE)
      end
      result << (SPACE + (HYPHEN * size) + SPACE)
      size.times do
        result << ((SPACE * (size + 1)) + PIPE)
      end
      result << (SPACE + (HYPHEN * size) + SPACE)
      result
    end

    def make4
      result = []
      result << empty_line
      size.times do
        result << (PIPE + (SPACE * size) + PIPE)
      end
      result << (SPACE + (HYPHEN * size) + SPACE)
      size.times do
        result << ((SPACE * (size + 1)) + PIPE)
      end
      result << empty_line
      result
    end

    def empty_line
      SPACE * (size + 2)
    end
  end

  class Parser
    attr_reader :size, :number
    def initialize(size, number)
      @size = size
      @number = number
      validate_inputs
    end

    def validate_inputs
      raise ArgumentError, "Invalid size! Received #{size}" unless (1...10).include? size
      raise ArgumentError, "Invalid number! Received #{number}" unless (1...99_999_999).include? number
    end

    def self.parse(input_string)
      if input_string =~ /^(?<size>\d+)\s(?<number>\d+)\s*$/
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
