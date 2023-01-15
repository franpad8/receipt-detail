# Utility/Helper methods

def parse_order_lines lines
  regex = /^(\d+)\s+([\w\s]+)\sat\s+(\d+\.\d+)$/
  lines = lines.split("\n").map(&:strip).reject(&:empty?)
  raise_format_error if lines.empty?

  lines.map do |line|
    match = line.match(regex)
    raise_format_error if match.nil? || match.length != 4

    quantity, name, price = match.to_a[1..-1]

    { quantity: quantity.to_i, name: name, price: price.to_f.round(2) }
  end
end

def print_receipt receipt
  receipt[:items].each do |item|
    puts format('%d %s: %.2f', item[:quantity], item[:name], item[:total])
  end
  puts format('Sales Taxes: %.2f', receipt[:tax_total])
  puts "Total: #{receipt[:total]}"
end

def raise_format_error
  raise StandardError.new("Invalid input format")
end
