#!/usr/bin/env ruby
require_relative 'lib/receipt_calculator'

def main str
  order_lines = parse_order_lines(str)
  receipt = ReceiptCalculator.call order_lines

  print_receipt receipt
end

def parse_order_lines lines
  regex = /^(\d+)\s+([\w\s]+)\sat\s+(\d+\.\d+)$/
  lines = lines.split("\n")
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
    puts "#{item[:quantity]} #{item[:name]}: #{item[:total]}"
  end
  puts "Sales Taxes: #{receipt[:tax_total]}"
  puts "Total: #{receipt[:total]}"
end

def raise_format_error
  raise StandardError.new("Invalid input format")
end

begin
  if __FILE__ == $PROGRAM_NAME
    main ARGF.readlines.map(&:chomp)
  end
rescue Error => e
  puts "Error: #{e.message}"
  exit 1
end
