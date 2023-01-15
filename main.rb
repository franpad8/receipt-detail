#!/usr/bin/env ruby
require_relative 'lib/utils'
require_relative 'lib/receipt_calculator'

def main str
  order_lines = parse_order_lines(str)
  print_receipt ReceiptCalculator.call(order_lines)
end

begin
  if __FILE__ == $PROGRAM_NAME
    main ARGF.read
  end
rescue StandardError => e
  puts "Error: #{e.message}"
  exit 1
end
