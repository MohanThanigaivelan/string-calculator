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

    context "with default delimiter" do
      it "returns sum of numbers in a comma-separated string" do
        expect(StringCalculator.add("1,2")).to eql(3)
      end

      it "returns sum of numbers in comma and new line delimiter string" do
        expect(StringCalculator.add("3\n4,5")).to eql(12)
      end
    end

    context "with custom delimiter" do
      it "return sum of numbers by using the custom delimiter provided in the string" do
        expect(StringCalculator.add("//;\n1;2")).to eql(3)
      end

      it "return sum of numbers by safely escaping regex special character delimiters" do
        expect(StringCalculator.add("//[\n1[2[3[4")).to eql(10)
      end
    end

    context "with both default and custom delimiter" do
      it "return sum of numbers by splitting using default delimiter and also custom delimiter provided in the string" do
        expect(StringCalculator.add("//;\n1;2,3\n4")).to eql(10)
      end
    end

    context "negative numbers in the string" do
      it "should throw exception" do
        expect{ StringCalculator.add("2,-1000") }.to raise_error(RuntimeError, "negatives not allowed. Numbers: [-1000]")
      end

      it "shoudn't throw exception when negative sign is the custom delimiter" do
        expect(StringCalculator.add("//-\n1-2-3-4")).to eql(10)
      end
    end
  end
end