module StringCalculator
  def self.add(input_string)
    return 0 if input_string.empty?

    default_delimiters = ["," , "\n"]
    custom_delimiters, numbers = get_delimiter_and_numbers(input_string)
    delimiters = []
    (custom_delimiters + default_delimiters).each_with_index do |match, index|
      if index == 0
        delimiters = Regexp.escape(match)
      else
        delimiters = delimiters + "|#{Regexp.escape(match)}"
      end
    end
    delimiters = /#{delimiters}/

    numbers_array = numbers.split(delimiters).map(&:to_i)
    negative_numbers = numbers_array.select{ |num| num < 0 }

    unless negative_numbers.empty?
      raise "negatives not allowed. Numbers: #{negative_numbers}"
    end

    if custom_delimiters.size == 1 && custom_delimiters.first == "*"
      numbers_array.inject(1) { |sum, number|   sum * number }
    else
      numbers_array.inject(0) { |sum, number|  number < 1000  ? sum + number :  sum }
    end
  end

  private
  def self.get_delimiter_and_numbers(input_string)
    if input_string.start_with?("//")
      get_custom_delimiter_and_numbers(input_string)
    else
      [[] , input_string]
    end
  end

  def self.get_custom_delimiter_and_numbers(input_string)
    custom_delimiter, numbers = input_string[2..-1].split("\n", 2)
    delimiter = []
    if custom_delimiter.start_with?('[') && custom_delimiter.end_with?(']')
      custom_delimiter.scan(/\[(.*?)\]/).each do |match|
        delimiter.push(match[0])
      end
    else
      delimiter.push(custom_delimiter)
    end
    [delimiter, numbers]
  end
end