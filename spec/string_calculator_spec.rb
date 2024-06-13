require 'rspec'
require 'string_calculator'

describe StringCalculator do
  describe "add" do
    it "return 0 if input is an empty string" do
      expect(StringCalculator.add("")).to eql(0)
    end
  end
end