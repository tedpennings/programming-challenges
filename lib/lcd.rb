# Do I trust activesupport? not right now
# require 'active_support/core_ext/string'

module Lcd

  def self.print_from_text(text)
    trimmed_lines_with_content = String(text).lines.map(&:strip).reject { |l| l =~ /^\s*$/}
    terminator = trimmed_lines_with_content.pop
    unless terminator =~ /0\s+0/
      # this responsibility could live in the parser...
      raise ArgumentError, "Unexpected format! Expected '0 0' terminator"
    end
    trimmed_lines_with_content.each_with_index do |display_line, index|
      puts "\n" if index != 0
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
      total_row_count = (2 * size) + 3
      # puts "digit_series.map(&:size) #{digit_series.map(&:size)}"
      # puts "digit_series.map { |d| d.map(&:size) } #{digit_series.map { |d| d.map(&:size) }}"
      (0...total_row_count).each do |row_number|
        row = digit_series.map { |digit| digit[row_number] }
        output << row.join(SPACE)
        output << "\n" unless row_number == (total_row_count - 1)
        # puts "current size is #{output.size} for row #{row_number}"
      end
      # puts "final size is #{output.size}"
      puts output
    end

    private

    def make1
      result = []
      result.concat empty_line(1)
      2.times do
        result.concat right_pipe(size)
        result.concat empty_line(1)
      end
      result
    end

    def make2
      result = []
      result.concat hyphens(1)
      result.concat right_pipe(size)
      result.concat hyphens(1)
      result.concat left_pipe(size)
      result.concat hyphens(1)
      result
    end

    def make3
      result = []
      result.concat hyphens(1)
      result.concat right_pipe(size)
      result.concat hyphens(1)
      result.concat right_pipe(size)
      result.concat hyphens(1)
      result
    end

    def make4
      result = []
      result.concat empty_line(1)
      result.concat pipe_space_pipe(size)
      result.concat hyphens(1)
      result.concat right_pipe(size)
      result.concat empty_line(1)
      result
    end

    def make5
      result = []
      result.concat hyphens(1)
      result.concat left_pipe(size)
      result.concat hyphens(1)
      result.concat right_pipe(size)
      result.concat hyphens(1)
      result
    end

    def make6
      result = []
      result.concat hyphens(1)
      result.concat left_pipe(size)
      result.concat hyphens(1)
      result.concat pipe_space_pipe(size)
      result.concat hyphens(1)
      result
    end

    def make7
      result = []
      result.concat hyphens(1)
      2.times do
        result.concat right_pipe(size)
        result.concat empty_line(1)
      end
      result
    end

    def make8
      result = []
      result.concat hyphens(1)
      result.concat pipe_space_pipe(size)
      result.concat hyphens(1)
      result.concat pipe_space_pipe(size)
      result.concat hyphens(1)
      result
    end

    def make9
      result = []
      result.concat hyphens(1)
      result.concat pipe_space_pipe(size)
      result.concat hyphens(1)
      result.concat right_pipe(size)
      result.concat hyphens(1)
      result
    end

    def make0
      result = []
      result.concat hyphens(1)
      result.concat pipe_space_pipe(size)
      result.concat empty_line(1)
      result.concat pipe_space_pipe(size)
      result.concat hyphens(1)
      result
    end

    def copies_of(times, &block)
      (1..times).map(&block)
    end

    def empty_line(times)
      copies_of(times) { SPACE * (size + 2) }
    end

    def hyphens(times)
      copies_of(times) { (SPACE + (HYPHEN * size) + SPACE) }
    end

    def pipe_space_pipe(times)
      copies_of(times) { (PIPE + (SPACE * size) + PIPE) }
    end

    def left_pipe(times)
      copies_of(times) { (PIPE + (SPACE * (size + 1))) }
    end

    def right_pipe(times)
      copies_of(times) { ((SPACE * (size + 1)) + PIPE) }
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
      raise ArgumentError, "Invalid number! Received #{number}" unless (0...99_999_999).include? number
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
