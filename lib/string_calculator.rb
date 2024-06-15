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
      get_custom_delimiter(input_string)
    else
      [ /[\n,]/ , input_string]
    end
  end

  def self.get_custom_delimiter(input_string)
    custom_delimiter, numbers = input_string[2..-1].split("\n", 2)
    delimiter = ""
    if custom_delimiter.start_with?('[') && custom_delimiter.end_with?(']')
      custom_delimiter.scan(/\[(.*?)\]/).each_with_index do |match, index|
        if index == 0
          delimiter = Regexp.escape(match[0])
        else
          delimiter = delimiter + "|#{Regexp.escape(match[0])}"
        end
      end
    else
      delimiter = Regexp.escape(custom_delimiter)
    end
    [/[\n,]|#{delimiter}/, numbers]
  end
end