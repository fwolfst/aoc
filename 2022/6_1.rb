#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/6

input = ARGF.read.strip

puts "---"

r = input.chars.each_cons(4).with_index.map do |slice, idx|
  if slice.tally.values.all? {_1 == 1}
    idx + 4
  end
end
  
p r.compact.first
