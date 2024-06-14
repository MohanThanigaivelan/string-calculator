require 'rspec'
require 'string_calculator'

describe StringCalculator do
  describe "add" do
    it "return 0 if input is an empty string" do
      expect(StringCalculator.add("")).to eql(0)
    end

    it "return input string as number if there is no delimiter in the input string" do
      expect(StringCalculator.add("1")).to eql(1)
    end
  end
end