describe "#call" do
  context "item with price 0" do
    before do
      @item = { quantity: 1, name: "book", price: 0.0 }
    end

    it 'returns no tax fee' do
      expect(TaxCalculator.call(@item)).to equal(0.0)
    end
  end

  context "normal item" do
    before do
      @item = { quantity: 1, name: "music CD", price: 10.2}
    end

    it 'only applies basic tax (10%) rounded up to nearest 0.05' do
      expect(TaxCalculator.call(@item)).to equal(1.05)
    end
  end

  context "imported normal item" do
    before do
      @item = { quantity: 1, name: "imported computer", price: 10.1}
    end

    it 'applies import and basic taxes (15%) rounded up to nearest 0.05' do
      expect(TaxCalculator.call(@item)).to equal(1.55)
    end
  end

  context "food item" do
    before do
      @item = { quantity: 1, name: "chocolate", price: 10.0}
    end

    it 'does not apply any tax fee' do
      expect(TaxCalculator.call(@item)).to equal(0.0)
    end
  end

  context "imported food item" do
    before do
      @item = { quantity: 1, name: "imported chocolate", price: 10.2}
    end

    it 'only applies import tax (5%) rounded up to nearest 0.05' do
      expect(TaxCalculator.call(@item)).to equal(0.55)
    end
  end

  context "imported normal item with more than one quantity" do
    before do
      @item = { quantity: 3, name: "imported computer", price: 10.1}
    end

    it 'applies import and basic taxes (15% from total) rounded up to nearest 0.05' do
      expect(TaxCalculator.call(@item)).to equal(4.65)
    end
  end
end
