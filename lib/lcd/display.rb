require_relative 'digit_helper'

module Lcd
  class Display
    include DigitHelper

    attr_reader :size, :number

    def initialize(size, number)
      @size = size
      @number = number
    end

    def content
      output = ''
      array_of_arrays = transform_number_to_array_of_arrays_of_ascii
      (0...total_row_count).each do |row_number|
        # Iterates through each line of ASCII, starting at index 0, for all
        # digits (arrays) in that line of ASCII, joining that line with spaces
        row = array_of_arrays.map { |digit| digit[row_number] }.join(SPACE)
        output << row << NEWLINE
      end
      output
    end

    def print
      Kernel.print content
    end

    private

    # Returns an array of arrays. The outer array represents each digit.
    # The inner array is each line of ASCII needed to print that digit.
    # For example, this is 42:
    # [["    ", "|  |", "|  |", " -- ", "   |", "   |", "    "],
    #  [" -- ", "   |", "   |", " -- ", "|   ", "|   ", " -- "] ]
    def transform_number_to_array_of_arrays_of_ascii
      number.to_s.chars.map { |digit| send :"make#{digit}" }
    end

    def total_row_count
      @row_count ||= (2 * size) + 3
    end

    # Below there is a method for each digit, 0 through 9.
    # The methods return an array of ASCII for each line.
    # Here's zero:
    # [ " -- ",
    #   "|  |",
    #   "|  |",
    #   "    ",
    #   "|  |",
    #   "|  |",
    #   " -- " ]
    # Each method must return a complete 'rectangle' of text, so
    # multi-digit numbers can be stitched together by joining each
    # line with spaces.

    # There are many helpers from DigitHelpers. Here's a quick rundown:
    # * hypens(1) returns a single line of hyphens, as in the top of zero
    # * pipe_space_pipe(size) returns size-many copies if the string |  |
    # * empty_line(1) returns whitespace, but enough for that size digit
    # All helpers return an array of strings, scaled appropriately to the
    # size of the digits, and the requested count (the argument they take).

    def make0
      result = []
      result.concat hyphens(1)
      result.concat pipe_space_pipe(size)
      result.concat empty_line(1)
      result.concat pipe_space_pipe(size)
      result.concat hyphens(1)
      result
    end

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

  end
end
