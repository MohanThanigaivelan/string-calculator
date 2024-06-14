module StringCalculator
  def self.add(input_string)
    return 0 if input_string.empty?

    delimiters, numbers = get_delimiter(input_string)
    numbers.split(delimiters).map(&:to_i).sum
  end

  private
  def self.get_delimiter(input_string)
    if input_string.start_with?("//")
      custom_delimiter, numbers = input_string[2..-1].split("\n", 2)
      [/[\n,#{Regexp.escape(custom_delimiter)}]/ , numbers]
    else
      [ /[\n,]/ , input_string]
    end

  end
end