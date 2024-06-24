require 'rspec'
require 'string_calculator'

describe StringCalculator do
  describe "add" do
    context "without delimiter" do
      context "when input is empty" do
        it "returns 0" do
          expect(StringCalculator.add("")).to eql(0)
        end
      end

      context "when input is a single number" do
        it "returns the number itself" do
          expect(StringCalculator.add("1")).to eql(1)
        end
      end
    end

    context "when using default delimiter" do
      it "returns sum of numbers in a comma-separated string" do
        expect(StringCalculator.add("1,2")).to eql(3)
      end

      it "returns sum of numbers in comma and new line delimiter string" do
        expect(StringCalculator.add("3\n4,5")).to eql(12)
      end
    end

    context "when using custom delimiter" do
      context "with single delimiter of size 1" do
        it "return sum of numbers by using the custom delimiter provided in the string" do
          expect(StringCalculator.add("//;\n1;2")).to eql(3)
        end

        it "return multipy the number when custom delimiter is * operator" do
          expect(StringCalculator.add("//*\n4*6")).to eql(24)
        end

        it "return sum of numbers by safely escaping regex special character delimiters" do
          expect(StringCalculator.add("//[\n1[2[3[4")).to eql(10)
        end
      end

      context "with single  delimiter of size greater than 1" do
        it "return sum of number separated by a custom multiple-length delimiter" do
          expect(StringCalculator.add("//[***]\n1***2***3")).to eq(6)
        end
      end

      context "with multiple delimiters" do
        it "return sum of numbers separated by a multiple custom delimiters of size 1" do
          expect(StringCalculator.add("//[*][%]\n10*20%30")).to eq(60)
        end

        it "return sum of numbers separated by multiple custom delimiter of varying length" do
          expect(StringCalculator.add("//[*+<][&%]\n10*+<20&%30&%50*+<20")).to eq(130)
        end
      end

    end

    context "when using both default and custom delimiter" do
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

    it "shouldn't sum numbers greater than 1000 in the string" do
      expect(StringCalculator.add("2,1002,1934,21455")).to eq(2)
    end
  end
end