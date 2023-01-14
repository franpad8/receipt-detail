require_relative '../main'

describe "#main" do
  context "with no imported items in the shopping basket" do
    before do
      @shopping_basket = <<~TEXT
        2 book at 12.49
        1 music CD at 14.99
        1 chocolate bar at 0.85
      TEXT
    end

    it "outputs the receipt details" do
      result = <<~TEXT
        2 book: 24.98
        1 music CD: 16.49
        1 chocolate bar: 0.85
        Sales Taxes: 1.50
        Total: 42.32
      TEXT
      expect { main @shopping_basket }.to output(result).to_stdout
    end
  end

  context "with invalid input format" do
    context "with blank input" do
      before do
        @shopping_basket = "   \n   "
      end

      it "outputs error message" do
        expect { main @shopping_basket }.to raise_error(StandardError, "Invalid input format")
      end
    end

    context "word instead of decimal in the price" do
      before do
        @shopping_basket = <<~TEXT
          2 book at twelve
        TEXT
      end

      it "outputs error message" do
        expect { main @shopping_basket }.to raise_error(StandardError, "Invalid input format")
      end
    end

    context "with no price" do
      before do
        @shopping_basket = <<~TEXT
          1 music CD
        TEXT
      end

      it "outputs error message" do
        expect { main @shopping_basket }.to raise_error(StandardError, "Invalid input format")
      end
    end

    context "with no quantity" do
      before do
        @shopping_basket = <<~TEXT
          chocolate bar at 0.85
        TEXT
      end

      it "outputs error message" do
        expect { main @shopping_basket }.to raise_error(StandardError, "Invalid input format")
      end
    end
  end
end
