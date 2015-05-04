module Lcd
  module DigitHelper
    HYPHEN = '-'.freeze
    PIPE   = '|'.freeze
    SPACE  = ' '.freeze

    def copies_of(times, &block)
      if times == 1
        [ yield ]
      else
        (1..times).map(&block)
      end
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
end
