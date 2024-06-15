module StringCalculator
  def self.add(input_string)
    return 0 if input_string.empty?

    delimiters, numbers = get_delimiter(input_string)
    numbers_array = numbers.split(delimiters).map(&:to_i)
    negative_numbers = numbers_array.select{ |num| num < 0 }

    unless negative_numbers.empty?
      raise "negatives not allowed. Numbers: #{negative_numbers}"
    end
    numbers_array.inject(0) { |sum, number|  number < 1000  ? sum + number :  sum }
  end

  private
  def self.get_delimiter(input_string)
    if input_string.start_with?("//")
      custom_delimiter, numbers = input_string[2..-1].split("\n", 2)
      if custom_delimiter.start_with?('[') && custom_delimiter.end_with?(']')
        custom_delimiter = custom_delimiter[1..-2]
      end
      [/[\n,]|#{Regexp.escape(custom_delimiter)}/ , numbers]
    else
      [ /[\n,]/ , input_string]
    end

  end
end