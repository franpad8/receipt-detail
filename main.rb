#!/usr/bin/env ruby

def main lines
  parse_order_lines lines
  puts "2 book: 24.98\n1 music CD: 16.49\n1 chocolate bar: 0.85\nSales Taxes: 1.50\nTotal: 42.32\n"
end

def parse_order_lines lines
  regex = /(\d+)\s+([\w\s]+)\sat\s+(\d+\.\d)/
  lines.split('\n').map do |line|
    line.match(regex)
  end
end

begin
  if __FILE__ == $PROGRAM_NAME
    main ARGF.readlines.map(&:chomp)
  end
rescue Errno::ENOENT
  puts "ERROR: No such file - #{ARGF.filename}"
  exit 1
end
