module StringCalculator
  def self.add(numbers)
    return 0 if numbers.empty?

    delimiters = get_delimiter(numbers)
    numbers.split(delimiters).map(&:to_i).sum
  end

  private
  def self.get_delimiter(numbers)
    if numbers.start_with?("//")
      numbers.split("\n").first[2..-1]
    else
      /[\n,]/
    end

  end
end