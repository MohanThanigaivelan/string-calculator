require 'rspec'
require 'string_calculator'

describe StringCalculator do
  describe "add" do
    context "without delimiter" do
      it "return 0 if input is an empty string" do
        expect(StringCalculator.add("")).to eql(0)
      end

      it "return input string as number when it is not empty" do
        expect(StringCalculator.add("1")).to eql(1)
      end
    end

    context "with delimiter" do
      it "returns sum of numbers in a comma-separated string" do
        expect(StringCalculator.add("1,2")).to eql(3)
      end
    end
  end
end