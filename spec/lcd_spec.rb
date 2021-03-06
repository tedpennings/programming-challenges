require 'spec_helper'

require 'lcd'
require 'lcd_spec_helper'

describe Lcd do

  let(:path_to_textbook_example) { File.join(File.dirname(__FILE__), 'lcd_examples', 'textbook_example.txt') }

  it "can read files given a file path" do
    path = path_to_textbook_example
    _, expected = LcdSpecHelper.example(:textbook_example)
    expect { Lcd.print_from_file(path) }.to output(expected).to_stdout
  end

  it "can read files given a File object" do
    file = File.new(path_to_textbook_example)
    _, expected = LcdSpecHelper.example(:textbook_example)
    expect { Lcd.print_from_file(file) }.to output(expected).to_stdout
  end

  describe "examples from spec/lcd_examples" do
    LcdSpecHelper.examples_list.each do |example_name|
      it LcdSpecHelper.formatted_name(example_name) do
        input, expected = LcdSpecHelper.example(example_name)
        expect { Lcd.print_from_text(input) }.to output(expected).to_stdout
      end
    end
  end

  describe "text dimensions" do
    (1..3).each do |size|
      (0..105).step(size).each do |number|

        it "produces the correct height (rows) digit for #{number} in size #{size}" do
          result = Lcd::Display.new(size, number).content
          rows   = (2 * size) + 3
          expect(result.lines.length).to eq(rows)
        end

        it "produces the correct width (columns) digit for #{number} in size #{size}" do
          result = Lcd::Display.new(size, number).content
          digits_in_number = number.to_s.chars.length
          columns_per_digit = size + 2 # expected per textbook
          newline_chars_per_line = 1 # duh
          spaces_between_digits = digits_in_number - 1
          line_whitespace_chars = spaces_between_digits + newline_chars_per_line
          line_length = (columns_per_digit * digits_in_number) + line_whitespace_chars
          result.lines.each do |line|
            expect(line.length).to eq(line_length)
          end
        end

      end
    end
  end

  describe "parsing" do
    it "can read a simple string" do
      parsed = Lcd::Parser.parse '4 30'
      expect(parsed.number).to eq(30)
      expect(parsed.size).to eq(4)
    end

    it "raises an ArgumentError when parsing fails" do
      expect { Lcd::Parser.parse '4 30zzz' }.to raise_error(ArgumentError)
    end

    it "raises an argument error when the size is too low" do
      expect { Lcd::Parser.parse '0 30' }.to raise_error(ArgumentError)
    end

    it "raises an argument error when the size is too high" do
      expect { Lcd::Parser.parse '30 40' }.to raise_error(ArgumentError)
    end

    it "raises an argument error when the number is too low" do
      expect { Lcd::Parser.parse '3 -1' }.to raise_error(ArgumentError)
    end

    it "raises an argument error when the number is too high" do
      expect { Lcd::Parser.parse '3 489202953920' }.to raise_error(ArgumentError)
    end
  end

end
