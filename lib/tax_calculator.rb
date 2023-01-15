# Service to calculate total tax for an order item
class TaxCalculator

  def self.call(*args)
    new(*args).call
  end

  def initialize order_item
    @order_item = order_item
  end

  def call
    item_tax = 0.0
    item_tax += calculate_basic_tax if basic_taxable?
    item_tax += calculate_import_tax if import_taxable?

    # round up to nearest 0.05
    rounded = ((item_tax / 0.05).round * 0.05).round(2)
    rounded += 0.05 if rounded < item_tax
    (rounded * @order_item[:quantity]).round(2)
  end

  private
    def calculate_basic_tax
      (@order_item[:price] * 0.10).round(2)
    end

    def calculate_import_tax
      (@order_item[:price] * 0.05).round(2)
    end

    # Only books, food and medical products are exempt from basic sales tax
    def basic_taxable?
      @order_item[:name] !~ /(chocolate|book|pill)/i
    end

    # Import duty is applicable on all imported goods
    def import_taxable?
      @order_item[:name] =~ /imported/i
    end
end
