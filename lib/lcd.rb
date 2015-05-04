require 'lcd/parser'
require 'lcd/display'

module Lcd

  # There are two entry points to an LCD display:
  #  - a file with the right markup
  #  - a string with the right markup
  # The input should be structured like this
  #    3 58
  #    5 40
  #    0 0
  # In the above, the first column is the size, and the second
  # column is the actual number to print.
  # All inputs need to be terminated by a '0 0' line.
  # Size must be 1-10, and number 0-99,999,999, both inclusive.

  def self.print_from_file(file)
    filename = file.is_a?(String) ? file : File.path(file)
    print_from_text(File.read(filename))
  end

  def self.print_from_text(text)
    lines_to_display = trim_and_remove_terminator(text)
    lines_to_display.each_with_index do |display_config, index|
      puts "\n" if index > 0
      # display_config is a string like '3 128'
      Parser.parse(display_config).print
    end
  end

  private

  def self.trim_and_remove_terminator(text)
    trimmed_lines_with_content = String(text).lines.map(&:strip).reject { |l| l =~ /^\s*$/}
    last_line = trimmed_lines_with_content.pop
    assert_terminator(last_line)
    trimmed_lines_with_content
  end

  def self.assert_terminator(line)
    unless line =~ /0\s+0/
      raise ArgumentError, "Unexpected format! Expected '0 0' as final line with content"
    end
  end

end
