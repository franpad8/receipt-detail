#!/usr/bin/env ruby
require_relative 'lib/utils'
require_relative 'lib/receipt_calculator'

def main str
  order_lines = parse_order_lines(str)
  receipt = ReceiptCalculator.call order_lines

  print_receipt receipt
end

begin
  if __FILE__ == $PROGRAM_NAME
    main ARGF.readlines.map(&:chomp)
  end
rescue Error => e
  puts "Error: #{e.message}"
  exit 1
end
