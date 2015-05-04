module LcdSpecHelper

  class << self

    def lcd_examples_path
      File.join(File.dirname(__FILE__), 'lcd_examples')
    end

    def examples_list
      examples = Dir["#{lcd_examples_path}/*"].entries
      examples.reject!{|f| f =~ /solution\.txt$/ }
      examples.reject!{|f| f =~ /skip$/ }
      examples.map{|name| File.basename(name).gsub(/\.txt$/, '') }
    end

    def example(name)
      input_path = File.join(lcd_examples_path, "#{name}.txt")
      expected_path = File.join(lcd_examples_path, "#{name}_solution.txt")
      [File.read(input_path), File.read(expected_path)]
    end

    def formatted_name(name)
      /number_(?<number>[\d\w]+)_size_(?<size>[\d\w]+)/ =~ name
      "the number #{number} in size #{size} from example #{name}"
    end

  end

end
