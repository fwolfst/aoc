#!/usr/bin/env ruby

# Felix Wolfsteller
# https://adventofcode.com/2022/day/3

rucksacks_content = ARGF.readlines

puts "---"

doubles = rucksacks_content.flat_map do |line|
  compartment_size = line.length / 2
  comp1, comp2 = line[0...compartment_size], line[compartment_size..-1]
  comp1.chars & comp2.chars
end

def priority letter
  ord = letter.ord
  if ord >= 'a'.ord
    return ord - 'a'.ord + 1
  else
    return ord - 'A'.ord + 27
  end
end

puts doubles.map{priority _1}.sum
