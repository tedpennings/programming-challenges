require_relative 'digit_helper'

module Lcd
  class Display
    include DigitHelper

    attr_reader :size, :number
    def initialize(size, number)
      @size = size
      @number = number
    end

    def print
      output = ''
      digit_series = number.to_s.chars.map { |digit| send :"make#{digit}" }
      total_row_count = (2 * size) + 3
      (0...total_row_count).each do |row_number|
        row = digit_series.map { |digit| digit[row_number] }
        output << row.join(' ')
        output << "\n" unless row_number == (total_row_count - 1)
      end
      puts output
    end

    private

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
