require 'lcd/parser'
require 'lcd/display'

module Lcd

  def self.print_from_file(file)
    filename = (file.is_a?(String)) ? file : File.path(file)
    print_from_text(File.read(filename))
  end

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

end
