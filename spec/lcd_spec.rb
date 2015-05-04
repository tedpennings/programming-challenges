require 'spec_helper'
require 'lcd'
require 'lcd_spec_helper'

describe Lcd do

  LcdSpecHelper.examples_list.each do |example_name|
    it "produces #{LcdSpecHelper.formatted_name(example_name)}" do
      input, expected = LcdSpecHelper.example(example_name)
      expect { Lcd.print_from_text(input) }.to output(expected).to_stdout
    end
  end

  it "can read files given a filename" do
    filename = File.join(File.dirname(__FILE__), 'lcd_examples', 'textbook_example.txt')
    _, expected = LcdSpecHelper.example(:textbook_example)
    expect { Lcd.print_from_file(filename) }.to output(expected).to_stdout
  end

  it "can read files given a File object" do
    filename = File.join(File.dirname(__FILE__), 'lcd_examples', 'textbook_example.txt')
    file = File.new(filename)
    _, expected = LcdSpecHelper.example(:textbook_example)
    expect { Lcd.print_from_file(file) }.to output(expected).to_stdout
  end

  describe Lcd::Parser do
    it "can read a simple string" do
      parsed = Lcd::Parser.parse '4 30'
      expect(parsed.number).to be(30)
      expect(parsed.size).to eq(4)
    end

    it "raises an ArgumentError when parsing fails" do
      expect { Lcd::Parser.parse '4 30zzz' }.to raise_error(ArgumentError)
    end
  end

end
