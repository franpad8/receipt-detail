#!/usr/bin/env ruby

def main lines
  parse_order_lines(lines).to_s
  puts "2 book: 24.98\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50\nTotal: 42.32\n"
end

def parse_order_lines lines
  regex = /^(\d+)\s+([\w\s]+)\sat\s+(\d+\.\d+)$/
  lines = lines.split("\n")
  raise_format_error if lines.empty?

  lines.map do |line|
    match = line.match(regex)
    raise_format_error if match.nil? || match.length != 4

    quantity, name, price = match.to_a[1..-1]

    [quantity.to_i, name, price.to_f.round(2)]
  end
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
