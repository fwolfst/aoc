#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/6

require 'set'

input = ARGF.read.strip

puts "---"

r = input.chars.each_cons(14).with_index.map do |slice, idx|
  if slice.tally.values.all? {_1 == 1}
    idx + 14
  end
end
  

# shortened: p input.chars.each_cons(4).find_index { Set.new(_1).size == 4 } + 4

p r.compact.first
