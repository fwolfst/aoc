#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/3

rucksacks_content = ARGF.readlines

puts "---"

doubles = rucksacks_content.each_slice(3).flat_map do |lines|
  lines[0].chomp.chars & lines[1].chomp.chars & lines[2].chomp.chars
end.compact

def priority letter
  ord = letter.ord
  if ord >= 'a'.ord
    return ord - 'a'.ord + 1
  else
    return ord - 'A'.ord + 27
  end
end

puts doubles.map{priority _1}.sum
