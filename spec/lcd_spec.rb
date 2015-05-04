require 'spec_helper'
require 'lcd'
require 'lcd_spec_helper'

describe Lcd do

  LcdSpecHelper.examples_list.each do |example_name|
    it "properly parses #{example_name}" do
      input, expected = LcdSpecHelper.example(example_name)
      expect { Lcd.print_from_text(input) }.to output(expected).to_stdout
    end
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
