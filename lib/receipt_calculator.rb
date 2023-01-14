# Service to calculate and generate the shopping receipt
class ReceiptCalculator

  def self.call(*params)
    new(*params).call
  end

  def initialize order_items
    @order_items = order_items
  end

  def call
    total = 0.0
    tax_total = 0.0
    receipt_items = @order_items.map do |order_item|
      item_subtotal = (order_item[:quantity] * order_item[:price]).round(2)
      item_tax = 0.0

      item_total = item_subtotal + item_tax
      tax_total += item_tax

      total += item_total

      [quantity, name, item_total]
    end

    { items: receipt_items, tax_total: tax_total, total: total }
  end
end
